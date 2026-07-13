import 'dart:io';

const _usage = '''
Create a feature module using the repository architecture contract.

Usage:
  dart run tool/create_feature_module.dart <module_name> [options]

Options:
  --feature <feature_name>  Initial feature directory. Defaults to module_name.
  --description <text>      Package description.
  --no-codegen              Skip pub get, generators, format, and analyze.
  --root <path>             Repository root. Defaults to auto-detection.
  -h, --help                Show this help.

Examples:
  dart run tool/create_feature_module.dart client_orders
  dart run tool/create_feature_module.dart admin_reports --feature reports
''';

final _snakeCasePattern = RegExp(r'^[a-z][a-z0-9]*(?:_[a-z][a-z0-9]*)*$');

Future<void> main(List<String> arguments) async {
  try {
    final options = _Options.parse(arguments);
    if (options.showHelp) {
      stdout.write(_usage);
      return;
    }

    final root = options.root ?? _findRepositoryRoot(Directory.current);
    final moduleDirectory = Directory(
      '${root.path}/modules/${options.moduleName}',
    );
    if (moduleDirectory.existsSync()) {
      throw StateError('Module already exists: ${moduleDirectory.path}');
    }

    _createModule(root, moduleDirectory, options);
    _addModuleToWorkspace(root, options.moduleName);

    stdout.writeln('Created modules/${options.moduleName}.');

    if (!options.runCodegen) {
      stdout.writeln('Code generation skipped (--no-codegen).');
      return;
    }

    await _run('flutter', ['pub', 'get'], root);
    await _run('flutter', ['gen-l10n'], moduleDirectory);
    await _run(Platform.resolvedExecutable, [
      'run',
      'build_runner',
      'build',
    ], moduleDirectory);
    await _run(Platform.resolvedExecutable, [
      'format',
      'lib',
      'test',
    ], moduleDirectory);
    await _run('flutter', ['analyze'], moduleDirectory);

    stdout.writeln('Module ${options.moduleName} is generated and validated.');
  } on _UsageException catch (error) {
    stderr.writeln(error.message);
    stderr.write(_usage);
    exitCode = 64;
  } on Object catch (error) {
    stderr.writeln(error);
    exitCode = 1;
  }
}

void _createModule(
  Directory root,
  Directory moduleDirectory,
  _Options options,
) {
  final moduleName = options.moduleName;
  final featureName = options.featureName;
  final moduleClass = _toPascalCase(moduleName);
  final generatedAssetType = '\$Assets${moduleClass}Gen';
  final generatedAssetGetter = _toLowerCamelCase(moduleName);
  final description = options.description ?? '$moduleClass feature module.';

  final files = <String, String>{
    'README.md':
        '''
# $moduleName

$description

The package follows `docs/architecture/feature-module-structure.md`.
Localization and generated module assets are available internally through
`context.l10n` and `context.assets`. Internal context, assets, constants,
endpoints, and navigation paths must not be exported from the package barrel.
''',
    'pubspec.yaml':
        '''
name: $moduleName
description: $description
publish_to: none
version: 0.1.0
resolution: workspace

environment:
  sdk: ^3.12.0
  flutter: ">=3.44.0"

dependencies:
  flutter:
    sdk: flutter
  flutter_localizations:
    sdk: flutter

  get_it: ^9.2.0
  injectable: ^3.0.0
  intl: ^0.20.2

dev_dependencies:
  build_runner: ^2.13.0
  flutter_gen_runner: ^5.13.0+1
  flutter_test:
    sdk: flutter
  flutter_lints: ^6.0.0
  injectable_generator: ^3.0.2

flutter:
  generate: true
  assets:
    - assets/$moduleName/

flutter_gen:
  assets:
    outputs:
      package_parameter_enabled: true
''',
    'build.yaml': '''
targets:
  \$default:
    builders:
      injectable_generator:injectable_builder:
        options:
          auto_register: true
          generate_for_injectable: true

      flutter_gen_runner:
        options:
          output: lib/gen/
          line_length: 80
''',
    'l10n.yaml':
        '''
arb-dir: lib/l10n
template-arb-file: ${moduleName}_en.arb
output-dir: lib/gen/l10n
output-localization-file: ${moduleName}_localizations.dart
output-class: ${moduleClass}Localizations
nullable-getter: false
''',
    'lib/$moduleName.dart':
        '''
library;

export 'gen/l10n/${moduleName}_localizations.dart';
export 'src/common/config/di/${moduleName}_di.dart';
export 'src/common/config/di/${moduleName}_di.module.dart';
''',
    'lib/l10n/${moduleName}_en.arb': '''
{
  "@@locale": "en"
}
''',
    'lib/l10n/${moduleName}_kk.arb': '''
{
  "@@locale": "kk"
}
''',
    'lib/l10n/${moduleName}_ru.arb': '''
{
  "@@locale": "ru"
}
''',
    'lib/src/common/${moduleName}_context_x.dart':
        '''
import 'package:$moduleName/gen/assets.gen.dart';
import 'package:$moduleName/gen/l10n/${moduleName}_localizations.dart';
import 'package:flutter/widgets.dart';

extension ${moduleClass}ContextX on BuildContext {
  ${moduleClass}Localizations get l10n =>
      ${moduleClass}Localizations.of(this);

  $generatedAssetType get assets => Assets.$generatedAssetGetter;
}
''',
    'lib/src/common/config/di/${moduleName}_di.dart':
        '''
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import '${moduleName}_di.module.dart';

@InjectableInit.microPackage()
Future<void> configure${moduleClass}Dependencies() async =>
    ${moduleClass}PackageModule().init(GetItHelper(GetIt.instance));
''',
    'test/common/${moduleName}_context_x_test.dart':
        '''
import 'package:$moduleName/gen/assets.gen.dart';
import 'package:$moduleName/gen/l10n/${moduleName}_localizations.dart';
import 'package:$moduleName/src/common/${moduleName}_context_x.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('exposes generated localization and assets', (tester) async {
    await tester.pumpWidget(
      Localizations(
        locale: const Locale('en'),
        delegates: const [
          DefaultWidgetsLocalizations.delegate,
          ${moduleClass}Localizations.delegate,
        ],
        child: Builder(
          builder: (context) {
            expect(context.l10n, isA<${moduleClass}Localizations>());
            expect(context.assets, same(Assets.$generatedAssetGetter));
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  });
}
''',
  };

  final emptyDirectories = <String>[
    'assets/$moduleName/icons',
    'assets/$moduleName/images',
    'assets/$moduleName/files',
    'lib/src/features/$featureName/data',
    'lib/src/features/$featureName/domain',
    'lib/src/features/$featureName/presentation',
    'test/features/$featureName',
  ];

  for (final entry in files.entries) {
    final file = File('${moduleDirectory.path}/${entry.key}');
    file.parent.createSync(recursive: true);
    file.writeAsStringSync('${entry.value.trimLeft()}\n');
  }

  File('${moduleDirectory.path}/assets/$moduleName/.gitkeep')
    ..parent.createSync(recursive: true)
    ..writeAsStringSync('');

  for (final path in emptyDirectories) {
    final marker = File('${moduleDirectory.path}/$path/.gitkeep');
    marker.parent.createSync(recursive: true);
    marker.writeAsStringSync('');
  }

  stdout.writeln('Repository: ${root.path}');
}

void _addModuleToWorkspace(Directory root, String moduleName) {
  final pubspec = File('${root.path}/pubspec.yaml');
  if (!pubspec.existsSync()) {
    throw StateError('Root pubspec.yaml was not found in ${root.path}.');
  }

  final workspaceEntry = '  - modules/$moduleName';
  final lines = pubspec.readAsLinesSync();
  if (lines.any((line) => line.trim() == '- modules/$moduleName')) {
    return;
  }

  final workspaceIndex = lines.indexWhere((line) => line == 'workspace:');
  if (workspaceIndex == -1) {
    throw StateError('Root pubspec.yaml does not define a workspace.');
  }

  var insertionIndex = lines.length;
  for (var index = workspaceIndex + 1; index < lines.length; index++) {
    final line = lines[index];
    if (line.isNotEmpty && !line.startsWith(' ') && !line.startsWith('#')) {
      insertionIndex = index;
      break;
    }
  }

  while (insertionIndex > workspaceIndex + 1 &&
      lines[insertionIndex - 1].isEmpty) {
    insertionIndex--;
  }

  lines.insert(insertionIndex, workspaceEntry);
  pubspec.writeAsStringSync('${lines.join('\n')}\n');
}

Directory _findRepositoryRoot(Directory start) {
  var current = start.absolute;
  while (true) {
    final pubspec = File('${current.path}/pubspec.yaml');
    final modules = Directory('${current.path}/modules');
    if (pubspec.existsSync() && modules.existsSync()) {
      final contents = pubspec.readAsStringSync();
      if (contents.contains('\nworkspace:')) {
        return current;
      }
    }

    final parent = current.parent;
    if (parent.path == current.path) {
      throw StateError(
        'Could not find the repository root from ${start.path}.',
      );
    }
    current = parent;
  }
}

Future<void> _run(
  String executable,
  List<String> arguments,
  Directory workingDirectory,
) async {
  stdout.writeln('\n> $executable ${arguments.join(' ')}');
  final process = await Process.start(
    executable,
    arguments,
    workingDirectory: workingDirectory.path,
    mode: ProcessStartMode.inheritStdio,
  );
  final result = await process.exitCode;
  if (result != 0) {
    throw ProcessException(
      executable,
      arguments,
      'Command failed in ${workingDirectory.path}',
      result,
    );
  }
}

String _toPascalCase(String value) => value
    .split('_')
    .map((part) => '${part[0].toUpperCase()}${part.substring(1)}')
    .join();

String _toLowerCamelCase(String value) {
  final pascalCase = _toPascalCase(value);
  return '${pascalCase[0].toLowerCase()}${pascalCase.substring(1)}';
}

final class _Options {
  const _Options({
    required this.moduleName,
    required this.featureName,
    required this.runCodegen,
    required this.showHelp,
    this.description,
    this.root,
  });

  final String moduleName;
  final String featureName;
  final String? description;
  final bool runCodegen;
  final bool showHelp;
  final Directory? root;

  factory _Options.parse(List<String> arguments) {
    if (arguments.contains('-h') || arguments.contains('--help')) {
      return const _Options(
        moduleName: '',
        featureName: '',
        runCodegen: false,
        showHelp: true,
      );
    }

    String? moduleName;
    String? featureName;
    String? description;
    Directory? root;
    var runCodegen = true;

    for (var index = 0; index < arguments.length; index++) {
      final argument = arguments[index];
      switch (argument) {
        case '--feature':
          featureName = _optionValue(arguments, ++index, argument);
        case '--description':
          description = _optionValue(arguments, ++index, argument);
        case '--root':
          root = Directory(_optionValue(arguments, ++index, argument));
        case '--no-codegen':
          runCodegen = false;
        default:
          if (argument.startsWith('-')) {
            throw _UsageException('Unknown option: $argument\n');
          }
          if (moduleName != null) {
            throw _UsageException('Only one module_name is allowed.\n');
          }
          moduleName = argument;
      }
    }

    if (moduleName == null) {
      throw const _UsageException('module_name is required.\n');
    }
    _validateName(moduleName, 'module_name');

    final resolvedFeatureName = featureName ?? moduleName;
    _validateName(resolvedFeatureName, 'feature_name');

    return _Options(
      moduleName: moduleName,
      featureName: resolvedFeatureName,
      description: description,
      runCodegen: runCodegen,
      showHelp: false,
      root: root?.absolute,
    );
  }
}

String _optionValue(List<String> arguments, int index, String option) {
  if (index >= arguments.length || arguments[index].startsWith('-')) {
    throw _UsageException('$option requires a value.\n');
  }
  return arguments[index];
}

void _validateName(String value, String label) {
  if (!_snakeCasePattern.hasMatch(value)) {
    throw _UsageException(
      '$label must use lower snake_case and start with a letter: $value\n',
    );
  }
}

final class _UsageException implements Exception {
  const _UsageException(this.message);

  final String message;
}
