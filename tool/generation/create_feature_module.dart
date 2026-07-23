import 'dart:io';

const _usage = '''
Create a feature module using the repository architecture contract.

Usage:
  dart run tool/generation/create_feature_module.dart <module_name> [options]

Options:
  --feature <feature_name>  Initial feature directory. Defaults to module_name.
  --description <text>      Package description.
  --no-codegen              Skip pub get, generators, format, and analyze.
  --root <path>             Repository root. Defaults to auto-detection.
  -h, --help                Show this help.

Examples:
  dart run tool/generation/create_feature_module.dart client_orders
  dart run tool/generation/create_feature_module.dart admin_reports --feature reports
''';

Future<void> main(List<String> arguments) async {
  final options = _parseArguments(arguments);
  if (options.showHelp) {
    stdout.write(_usage);
    return;
  }

  final moduleName = options.moduleName;
  if (moduleName == null) _usageError('module_name is required.');
  _validateName(moduleName, 'module_name');

  final featureName = options.featureName ?? moduleName;
  _validateName(featureName, 'feature_name');

  final repositoryRoot = options.repositoryRoot == null
      ? _findRepositoryRoot()
      : _resolveRepositoryRoot(options.repositoryRoot!);
  _validateRepositoryRoot(repositoryRoot);

  final moduleDirectory = Directory.fromUri(
    repositoryRoot.uri.resolve('modules/$moduleName/'),
  );
  if (moduleDirectory.existsSync()) {
    stderr.writeln('Module already exists: ${moduleDirectory.path}');
    exit(1);
  }

  final moduleClass = _toPascalCase(moduleName);
  final assetGetter =
      '${moduleClass[0].toLowerCase()}${moduleClass.substring(1)}';
  final description = options.description ?? '$moduleClass feature module.';

  _createScaffold(
    moduleDirectory: moduleDirectory,
    moduleName: moduleName,
    moduleClass: moduleClass,
    featureName: featureName,
    assetGetter: assetGetter,
    description: description,
  );
  _addWorkspaceEntry(repositoryRoot, moduleName);

  stdout
    ..writeln('Repository: ${repositoryRoot.path}')
    ..writeln('Created modules/$moduleName.');

  if (!options.runCodegen) {
    stdout.writeln('Code generation skipped (--no-codegen).');
    return;
  }

  await _run(repositoryRoot, 'flutter', ['pub', 'get']);
  await _run(moduleDirectory, 'flutter', ['gen-l10n']);
  await _run(
    moduleDirectory,
    'dart',
    ['run', 'build_runner', 'build'],
  );
  await _run(moduleDirectory, 'dart', ['format', 'lib', 'test']);
  await _run(moduleDirectory, 'flutter', ['analyze']);

  stdout.writeln('Module $moduleName is generated and validated.');
}

void _createScaffold({
  required Directory moduleDirectory,
  required String moduleName,
  required String moduleClass,
  required String featureName,
  required String assetGetter,
  required String description,
}) {
  final directories = [
    'assets/$moduleName/icons',
    'assets/$moduleName/images',
    'assets/$moduleName/files',
    'lib/l10n',
    'lib/src/common/config/di',
    'lib/src/features/$featureName/data',
    'lib/src/features/$featureName/domain',
    'lib/src/features/$featureName/presentation',
    'test/common/presentation/extensions',
    'test/features/$featureName',
  ];
  for (final path in directories) {
    Directory.fromUri(
      moduleDirectory.uri.resolve('$path/'),
    ).createSync(recursive: true);
  }

  _write(
    moduleDirectory,
    'README.md',
    '''
# $moduleName

$description

The package follows `docs/architecture/feature-module-structure.md`.
Localization and generated module assets are available internally through
`context.l10n` and `context.assets`. Internal context, assets, constants,
endpoints, and navigation paths must not be exported from the package barrel.
''',
  );
  _write(
    moduleDirectory,
    'pubspec.yaml',
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

  core:
    path: ../core
  design_system:
    path: ../design_system
  shared:
    path: ../shared
  dartz: ^0.10.1
  equatable: ^2.0.8
  flutter_bloc: ^9.1.1
  freezed_annotation: ^3.1.0
  get_it: ^9.2.0
  injectable: ^3.0.0
  intl: ^0.20.2
  json_annotation: ^4.12.0

dev_dependencies:
  build_runner: ^2.13.0
  flutter_gen_runner: ^5.13.0+1
  flutter_test:
    sdk: flutter
  flutter_lints: ^6.0.0
  freezed: ^3.2.5
  injectable_generator: ^3.0.2
  json_serializable: ^6.13.0
  mocktail: ^1.0.5

flutter:
  generate: true
  assets:
    - assets/$moduleName/

flutter_gen:
  assets:
    outputs:
      package_parameter_enabled: true
''',
  );
  _write(
    moduleDirectory,
    'build.yaml',
    r'''
targets:
  $default:
    builders:
      source_gen:combining_builder:
        options:
          ignore_for_file:
            - unnecessary_null_checks
            - document_ignores

      json_serializable:
        options:
          field_rename: snake

      freezed:
        generate_for:
          - lib/src/features/**/domain/entities/**.dart
          - lib/src/features/**/presentation/blocs/**.dart
        options:
          to_json: false
          from_json: false
          when: false
          map: false

      injectable_generator:injectable_builder:
        options:
          auto_register: true
          generate_for_injectable: true

      flutter_gen_runner:
        options:
          output: lib/gen/
          line_length: 80
''',
  );
  _write(
    moduleDirectory,
    'l10n.yaml',
    '''
arb-dir: lib/l10n
template-arb-file: ${moduleName}_en.arb
output-dir: lib/gen/l10n
output-localization-file: ${moduleName}_localizations.dart
output-class: ${moduleClass}Localizations
nullable-getter: false
''',
  );
  _write(
    moduleDirectory,
    'lib/$moduleName.dart',
    '''
library;

export 'gen/l10n/${moduleName}_localizations.dart';
export 'src/common/config/di/${moduleName}_di.dart';
export 'src/common/config/di/${moduleName}_di.module.dart';
''',
  );

  for (final locale in ['en', 'kk', 'ru']) {
    _write(
      moduleDirectory,
      'lib/l10n/${moduleName}_$locale.arb',
      '''
{
  "@@locale": "$locale"
}
''',
    );
  }

  _write(
    moduleDirectory,
    'lib/src/common/presentation/extensions/${moduleName}_context_x.dart',
    '''
import 'package:$moduleName/gen/assets.gen.dart';
import 'package:$moduleName/gen/l10n/${moduleName}_localizations.dart';
import 'package:flutter/widgets.dart';

extension ${moduleClass}ContextX on BuildContext {
  ${moduleClass}Localizations get l10n =>
      ${moduleClass}Localizations.of(this);

  \$Assets${moduleClass}Gen get assets => Assets.$assetGetter;
}
''',
  );
  _write(
    moduleDirectory,
    'lib/src/common/config/di/${moduleName}_di.dart',
    '''
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import '${moduleName}_di.module.dart';

@InjectableInit.microPackage()
Future<void> configure${moduleClass}Dependencies() async =>
    ${moduleClass}PackageModule().init(GetItHelper(GetIt.instance));
''',
  );
  _write(
    moduleDirectory,
    'test/common/presentation/extensions/${moduleName}_context_x_test.dart',
    '''
import 'package:$moduleName/gen/assets.gen.dart';
import 'package:$moduleName/gen/l10n/${moduleName}_localizations.dart';
import 'package:$moduleName/src/common/presentation/extensions/${moduleName}_context_x.dart';
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
            expect(context.assets, same(Assets.$assetGetter));
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  });
}
''',
  );

  final emptyFiles = [
    'assets/$moduleName/.gitkeep',
    'assets/$moduleName/icons/.gitkeep',
    'assets/$moduleName/images/.gitkeep',
    'assets/$moduleName/files/.gitkeep',
    'lib/src/features/$featureName/data/.gitkeep',
    'lib/src/features/$featureName/domain/.gitkeep',
    'lib/src/features/$featureName/presentation/.gitkeep',
    'test/features/$featureName/.gitkeep',
  ];
  for (final path in emptyFiles) {
    File.fromUri(moduleDirectory.uri.resolve(path)).createSync(recursive: true);
  }
}

void _write(Directory root, String path, String contents) {
  final normalizedContents = contents.startsWith('\n')
      ? contents.substring(1)
      : contents;
  File.fromUri(root.uri.resolve(path))
    ..createSync(recursive: true)
    ..writeAsStringSync(normalizedContents);
}

void _addWorkspaceEntry(Directory repositoryRoot, String moduleName) {
  final pubspec = File.fromUri(repositoryRoot.uri.resolve('pubspec.yaml'));
  final source = pubspec.readAsStringSync();
  final workspaceEntry = '  - modules/$moduleName';
  if (source.split('\n').contains(workspaceEntry)) return;

  final workspace = RegExp(
    r'^workspace:\n(?:[ \t]+.*\n)*',
    multiLine: true,
  ).firstMatch(source);
  if (workspace == null) {
    stderr.writeln('Root pubspec.yaml does not define a workspace.');
    exit(1);
  }

  final replacement = '${workspace.group(0)}$workspaceEntry\n';
  pubspec.writeAsStringSync(
    source.replaceRange(
      workspace.start,
      workspace.end,
      replacement,
    ),
  );
}

Future<void> _run(
  Directory workingDirectory,
  String executable,
  List<String> arguments,
) async {
  stdout.writeln('\n> ${[executable, ...arguments].join(' ')}');
  final process = await Process.start(
    executable,
    arguments,
    workingDirectory: workingDirectory.path,
    mode: ProcessStartMode.inheritStdio,
  );
  final result = await process.exitCode;
  if (result != 0) exit(result);
}

_Options _parseArguments(List<String> arguments) {
  String? moduleName;
  String? featureName;
  String? description;
  String? repositoryRoot;
  var runCodegen = true;

  for (var index = 0; index < arguments.length; index++) {
    final argument = arguments[index];
    switch (argument) {
      case '-h' || '--help':
        return const _Options(showHelp: true);
      case '--feature':
        featureName = _optionValue(arguments, ++index, argument);
        continue;
      case '--description':
        description = _optionValue(arguments, ++index, argument);
        continue;
      case '--root':
        repositoryRoot = _optionValue(arguments, ++index, argument);
        continue;
      case '--no-codegen':
        runCodegen = false;
        continue;
      default:
        if (argument.startsWith('-')) {
          _usageError('Unknown option: $argument');
        }
        if (moduleName != null) {
          _usageError('Only one module_name is allowed.');
        }
        moduleName = argument;
    }
  }

  return _Options(
    moduleName: moduleName,
    featureName: featureName,
    description: description,
    repositoryRoot: repositoryRoot,
    runCodegen: runCodegen,
  );
}

String _optionValue(List<String> arguments, int index, String option) {
  if (index >= arguments.length || arguments[index].startsWith('-')) {
    _usageError('$option requires a value.');
  }
  return arguments[index];
}

Never _usageError(String message) {
  stderr
    ..writeln(message)
    ..writeln()
    ..write(_usage);
  exit(64);
}

void _validateName(String value, String label) {
  if (!RegExp(r'^[a-z][a-z0-9]*(_[a-z][a-z0-9]*)*$').hasMatch(value)) {
    _usageError(
      '$label must use lower snake_case and start with a letter: $value',
    );
  }
}

String _toPascalCase(String value) => value
    .split('_')
    .map((part) => '${part[0].toUpperCase()}${part.substring(1)}')
    .join();

Directory _resolveRepositoryRoot(String path) {
  final directory = Directory(path).absolute;
  if (!directory.existsSync()) {
    stderr.writeln('Repository root does not exist: $path');
    exit(1);
  }
  return Directory(directory.resolveSymbolicLinksSync());
}

Directory _findRepositoryRoot() {
  var current = Directory.current.absolute;
  while (true) {
    final pubspec = File.fromUri(current.uri.resolve('pubspec.yaml'));
    final modules = Directory.fromUri(current.uri.resolve('modules/'));
    if (pubspec.existsSync() &&
        modules.existsSync() &&
        RegExp(
          '^workspace:',
          multiLine: true,
        ).hasMatch(pubspec.readAsStringSync())) {
      return current;
    }

    final parent = current.parent;
    if (parent.path == current.path) {
      stderr.writeln(
        'Could not find the repository root from ${Directory.current.path}.',
      );
      exit(1);
    }
    current = parent;
  }
}

void _validateRepositoryRoot(Directory root) {
  if (!File.fromUri(root.uri.resolve('pubspec.yaml')).existsSync()) {
    stderr.writeln('Root pubspec.yaml was not found in ${root.path}.');
    exit(1);
  }
  if (!Directory.fromUri(root.uri.resolve('modules/')).existsSync()) {
    stderr.writeln('Modules directory was not found in ${root.path}.');
    exit(1);
  }
}

class _Options {
  const _Options({
    this.moduleName,
    this.featureName,
    this.description,
    this.repositoryRoot,
    this.runCodegen = true,
    this.showHelp = false,
  });

  final String? moduleName;
  final String? featureName;
  final String? description;
  final String? repositoryRoot;
  final bool runCodegen;
  final bool showHelp;
}
