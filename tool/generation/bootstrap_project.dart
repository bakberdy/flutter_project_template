import 'dart:convert';
import 'dart:io';

import 'package:yaml/yaml.dart';

const _templateAndroidApplicationId = 'com.example.client_app';
const _templateIosBundleId = 'com.example.clientApp';
const _templateIosTeam = 'C466ZHPP34';

const _usage = '''
Apply product and platform identity from project.yaml.

Usage:
  dart run tool/generation/bootstrap_project.dart [options]

Optional:
  --config <path>          Configuration path relative to the repository root.
                           Defaults to project.yaml.
  --dry-run                Print planned changes without writing files.
  --no-codegen             Skip pub get, localization generation, and analysis.
  --root <path>            Repository root. Defaults to auto-detection.
  -h, --help               Show this help.

Example:
  dart run tool/generation/bootstrap_project.dart --dry-run
''';

Future<void> main(List<String> arguments) async {
  try {
    final options = _parseArguments(arguments);
    if (options.showHelp) {
      stdout.write(_usage);
      return;
    }

    final configuredRoot = options.repositoryRoot;
    final repositoryRoot = configuredRoot == null
        ? findRepositoryRoot()
        : resolveRepositoryRoot(configuredRoot);
    final projectFile = ProjectFile.load(
      repositoryRoot,
      options.configurationPath,
    );
    final config = projectFile.configuration;
    final plan = createBootstrapPlan(
      repositoryRoot,
      config,
      previousConfig: projectFile.appliedConfiguration,
      configurationPath: options.configurationPath,
    );

    stdout
      ..writeln('Repository: ${repositoryRoot.path}')
      ..writeln('Project: ${config.displayName}')
      ..writeln('Application ID: ${config.applicationId}')
      ..writeln('Apple team: ${config.iosTeam}')
      ..writeln()
      ..writeln('Planned changes:');
    for (final change in plan.fileChanges) {
      stdout.writeln('- ${change.relativePath}');
    }
    final activityMove = plan.mainActivityMove;
    if (activityMove != null) {
      stdout.writeln(
        '- ${activityMove.sourceRelativePath} -> '
        '${activityMove.targetRelativePath}',
      );
    }
    if (plan.isEmpty) {
      stdout.writeln('- none\n\nConfiguration is already applied.');
      return;
    }

    if (options.dryRun) {
      stdout.writeln('\nDry run complete. No files were changed.');
      return;
    }

    plan.apply();
    stdout.writeln('\nProject identity was updated.');

    if (!options.runCodegen) {
      stdout.writeln(
        'Generation and validation skipped (--no-codegen). '
        'Run flutter gen-l10n in apps/admin_app before committing.',
      );
      return;
    }

    await _run(repositoryRoot, 'flutter', const ['pub', 'get']);
    await _run(
      Directory.fromUri(repositoryRoot.uri.resolve('apps/admin_app/')),
      'flutter',
      const ['gen-l10n'],
    );
    await _run(repositoryRoot, 'dart', const ['format', '.']);
    await _run(repositoryRoot, 'dart', const ['analyze']);

    stdout.writeln('${config.displayName} is bootstrapped and validated.');
  } on BootstrapException catch (error) {
    stderr
      ..writeln(error.message)
      ..writeln()
      ..write(_usage);
    exitCode = 64;
  }
}

final class BootstrapConfig {
  factory BootstrapConfig({
    required String projectName,
    required String organization,
    required String iosTeam,
    String? displayName,
    String? applicationId,
  }) {
    if (!RegExp(r'^[a-z][a-z0-9]*(_[a-z][a-z0-9]*)*$').hasMatch(projectName)) {
      throw BootstrapException(
        'project_name must use lower snake_case and start with a letter: '
        '$projectName',
      );
    }
    if (!RegExp(
      r'^[a-z][a-z0-9]*(\.[a-z][a-z0-9]*)+$',
    ).hasMatch(organization)) {
      throw BootstrapException(
        '--organization must be a lowercase reverse domain: $organization',
      );
    }
    if (!RegExp(r'^[A-Z0-9]{10}$').hasMatch(iosTeam)) {
      throw BootstrapException(
        '--ios-team must contain exactly ten uppercase letters or digits: '
        '$iosTeam',
      );
    }

    final trimmedDisplayName = displayName?.trim();
    final resolvedDisplayName =
        trimmedDisplayName != null && trimmedDisplayName.isNotEmpty
        ? trimmedDisplayName
        : _toDisplayName(projectName);
    if (resolvedDisplayName.contains(RegExp(r'[\r\n]')) ||
        resolvedDisplayName.length > 50) {
      throw const BootstrapException(
        '--display-name must be one line with at most 50 characters.',
      );
    }

    final identifierSegment = projectName.replaceAll('_', '');
    final resolvedApplicationId =
        applicationId ?? '$organization.$identifierSegment';
    if (!RegExp(
      r'^[a-z][a-z0-9]*(\.[a-z][a-z0-9]*)+$',
    ).hasMatch(resolvedApplicationId)) {
      throw BootstrapException(
        '--application-id must contain lowercase dot-separated identifiers: '
        '$resolvedApplicationId',
      );
    }

    return BootstrapConfig._(
      projectName: projectName,
      displayName: resolvedDisplayName,
      organization: organization,
      applicationId: resolvedApplicationId,
      iosTeam: iosTeam,
    );
  }

  const BootstrapConfig._({
    required this.projectName,
    required this.displayName,
    required this.organization,
    required this.applicationId,
    required this.iosTeam,
  });

  final String projectName;
  final String displayName;
  final String organization;
  final String applicationId;
  final String iosTeam;

  String get adminDisplayName => '$displayName Admin';
}

final class ProjectFile {
  const ProjectFile({
    required this.configuration,
    required this.appliedConfiguration,
  });

  factory ProjectFile.load(Directory root, String relativePath) {
    final file = File.fromUri(root.uri.resolve(relativePath));
    if (!file.existsSync()) {
      throw BootstrapException(
        'Project configuration was not found: $relativePath',
      );
    }

    final Object? document;
    try {
      document = loadYaml(file.readAsStringSync());
    } on YamlException catch (error) {
      throw BootstrapException(
        'Invalid YAML in $relativePath: ${error.message}',
      );
    }
    if (document is! YamlMap) {
      throw BootstrapException('$relativePath must contain a YAML map.');
    }

    return ProjectFile(
      configuration: _configFromYaml(document, relativePath),
      appliedConfiguration: switch (document['applied']) {
        final YamlMap applied => _configFromYaml(
          applied,
          '$relativePath applied',
        ),
        null => null,
        _ => throw BootstrapException(
          '$relativePath applied must be a YAML map.',
        ),
      },
    );
  }

  final BootstrapConfig configuration;
  final BootstrapConfig? appliedConfiguration;
}

BootstrapConfig _configFromYaml(YamlMap yaml, String source) {
  return BootstrapConfig(
    projectName: _requiredYamlString(yaml, 'name', source),
    displayName: _requiredYamlString(yaml, 'display_name', source),
    organization: _requiredYamlString(yaml, 'organization', source),
    applicationId: _requiredYamlString(yaml, 'application_id', source),
    iosTeam: _requiredYamlString(yaml, 'ios_team', source),
  );
}

String _requiredYamlString(YamlMap yaml, String key, String source) {
  final value = yaml[key];
  if (value is! String || value.trim().isEmpty) {
    throw BootstrapException('$source must define a non-empty "$key".');
  }
  return value;
}

final class BootstrapPlan {
  const BootstrapPlan({
    required this.repositoryRoot,
    required this.fileChanges,
    required this.mainActivityMove,
  });

  final Directory repositoryRoot;
  final List<BootstrapFileChange> fileChanges;
  final BootstrapFileMove? mainActivityMove;

  bool get isEmpty => fileChanges.isEmpty && mainActivityMove == null;

  void apply() {
    final appliedChanges = <BootstrapFileChange>[];
    var activityMoved = false;

    try {
      for (final change in fileChanges) {
        change.apply(repositoryRoot);
        appliedChanges.add(change);
      }
      final move = mainActivityMove;
      if (move != null) {
        move.apply(repositoryRoot);
        activityMoved = true;
        _deleteEmptyAndroidPackageDirectories(
          repositoryRoot,
          move.sourceRelativePath,
        );
      }
    } on Object {
      final move = mainActivityMove;
      if (activityMoved && move != null) {
        move.rollback(repositoryRoot);
      }
      for (final change in appliedChanges.reversed) {
        change.rollback(repositoryRoot);
      }
      rethrow;
    }
  }
}

final class BootstrapFileChange {
  const BootstrapFileChange({
    required this.relativePath,
    required this.before,
    required this.after,
  });

  final String relativePath;
  final String? before;
  final String after;

  void apply(Directory root) {
    File.fromUri(
        root.uri.resolve(relativePath),
      )
      ..createSync(recursive: true)
      ..writeAsStringSync(after);
  }

  void rollback(Directory root) {
    final file = File.fromUri(root.uri.resolve(relativePath));
    final original = before;
    if (original == null) {
      if (file.existsSync()) file.deleteSync();
      return;
    }
    file.writeAsStringSync(original);
  }
}

final class BootstrapFileMove {
  const BootstrapFileMove({
    required this.sourceRelativePath,
    required this.targetRelativePath,
  });

  final String sourceRelativePath;
  final String targetRelativePath;

  void apply(Directory root) {
    final source = File.fromUri(root.uri.resolve(sourceRelativePath));
    final target = File.fromUri(root.uri.resolve(targetRelativePath));
    target.parent.createSync(recursive: true);
    source.renameSync(target.path);
  }

  void rollback(Directory root) {
    final source = File.fromUri(root.uri.resolve(sourceRelativePath));
    final target = File.fromUri(root.uri.resolve(targetRelativePath));
    if (!target.existsSync()) return;
    source.parent.createSync(recursive: true);
    target.renameSync(source.path);
  }
}

BootstrapPlan createBootstrapPlan(
  Directory repositoryRoot,
  BootstrapConfig config, {
  BootstrapConfig? previousConfig,
  String configurationPath = 'project.yaml',
}) {
  validateRepositoryRoot(repositoryRoot);

  final previous = previousConfig;
  final previousAndroidApplicationId =
      previous?.applicationId ?? _templateAndroidApplicationId;
  final previousIosBundleId = previous?.applicationId ?? _templateIosBundleId;
  final previousIosTeam = previous?.iosTeam ?? _templateIosTeam;
  final sourceActivityPath =
      'apps/client_app/android/app/src/main/kotlin/'
      '${previousAndroidApplicationId.replaceAll('.', '/')}/MainActivity.kt';
  final targetActivityPath =
      'apps/client_app/android/app/src/main/kotlin/'
      '${config.applicationId.replaceAll('.', '/')}/MainActivity.kt';
  final sourceActivity = File.fromUri(
    repositoryRoot.uri.resolve(sourceActivityPath),
  );
  final targetActivity = File.fromUri(
    repositoryRoot.uri.resolve(targetActivityPath),
  );
  if (!sourceActivity.existsSync()) {
    throw const BootstrapException(
      'Template MainActivity.kt was not found. The project might already be '
      'bootstrapped.',
    );
  }
  if (targetActivityPath != sourceActivityPath && targetActivity.existsSync()) {
    throw BootstrapException(
      'Target Android activity already exists: $targetActivityPath',
    );
  }

  final pendingSources = <String, String>{};
  var androidIdentifierReplacements = 0;
  var iosIdentifierReplacements = 0;
  var iosTeamReplacements = 0;

  for (final rootPath in ['apps/client_app/android', 'apps/client_app/ios']) {
    for (final file in _textFilesUnder(repositoryRoot, rootPath)) {
      final relativePath = _relativePath(repositoryRoot, file);
      final source = file.readAsStringSync();
      androidIdentifierReplacements += _countOccurrences(
        source,
        previousAndroidApplicationId,
      );
      iosIdentifierReplacements += _countOccurrences(
        source,
        previousIosBundleId,
      );
      iosTeamReplacements += _countOccurrences(source, previousIosTeam);
      final updated = source
          .replaceAll(previousAndroidApplicationId, config.applicationId)
          .replaceAll(previousIosBundleId, config.applicationId)
          .replaceAll(previousIosTeam, config.iosTeam);
      if (source != updated) pendingSources[relativePath] = updated;
    }
  }

  for (final file in _textFilesUnder(repositoryRoot, '.github')) {
    final relativePath = _relativePath(repositoryRoot, file);
    final source = file.readAsStringSync();
    androidIdentifierReplacements += _countOccurrences(
      source,
      previousAndroidApplicationId,
    );
    iosIdentifierReplacements += _countOccurrences(
      source,
      previousIosBundleId,
    );
    iosTeamReplacements += _countOccurrences(source, previousIosTeam);
    final updated = source
        .replaceAll(previousAndroidApplicationId, config.applicationId)
        .replaceAll(previousIosBundleId, config.applicationId)
        .replaceAll(previousIosTeam, config.iosTeam);
    if (source != updated) pendingSources[relativePath] = updated;
  }

  if ((previousAndroidApplicationId != config.applicationId &&
          androidIdentifierReplacements == 0) ||
      (previousIosBundleId != config.applicationId &&
          iosIdentifierReplacements == 0) ||
      (previousIosTeam != config.iosTeam && iosTeamReplacements == 0)) {
    throw const BootstrapException(
      'Expected template identifiers were not found. The project might '
      'already be bootstrapped or is not a supported template revision.',
    );
  }

  _replaceExact(
    repositoryRoot,
    pendingSources,
    'apps/client_app/android/app/src/main/AndroidManifest.xml',
    previous == null
        ? 'android:label="client_app"'
        : 'android:label="${_xmlEscape(previous.displayName)}"',
    'android:label="${_xmlEscape(config.displayName)}"',
  );
  _replaceExact(
    repositoryRoot,
    pendingSources,
    'apps/client_app/ios/Runner/Info.plist',
    '<string>${_xmlEscape(previous?.displayName ?? 'Client App')}</string>',
    '<string>${_xmlEscape(config.displayName)}</string>',
  );
  _replaceExact(
    repositoryRoot,
    pendingSources,
    'apps/client_app/ios/Runner/Info.plist',
    '<string>${_xmlEscape(previous?.projectName ?? 'client_app')}</string>',
    '<string>${_xmlEscape(config.projectName)}</string>',
  );
  _replaceExact(
    repositoryRoot,
    pendingSources,
    'apps/client_app/README.md',
    previous == null ? '# client_app' : '# ${previous.displayName} client app',
    '# ${config.displayName} client app',
  );
  _replaceExact(
    repositoryRoot,
    pendingSources,
    'apps/client_app/README.md',
    previous == null
        ? 'A new Flutter project.'
        : '${previous.displayName} mobile client application.',
    '${config.displayName} mobile client application.',
  );
  _replaceExact(
    repositoryRoot,
    pendingSources,
    'apps/client_app/pubspec.yaml',
    previous == null
        ? 'description: Client Flutter application.'
        : _pubspecDescription(
            '${previous.displayName} client Flutter application.',
          ),
    _pubspecDescription('${config.displayName} client Flutter application.'),
  );
  _replaceExact(
    repositoryRoot,
    pendingSources,
    'apps/admin_app/README.md',
    previous == null ? '# admin_app' : '# ${previous.displayName} admin app',
    '# ${config.displayName} admin app',
  );
  _replaceExact(
    repositoryRoot,
    pendingSources,
    'apps/admin_app/README.md',
    previous == null
        ? 'Flutter web administration panel.'
        : '${previous.displayName} web administration panel.',
    '${config.displayName} web administration panel.',
  );
  _replaceExact(
    repositoryRoot,
    pendingSources,
    'apps/admin_app/pubspec.yaml',
    previous == null
        ? 'description: Admin Flutter web application.'
        : _pubspecDescription(
            '${previous.displayName} admin Flutter web application.',
          ),
    _pubspecDescription('${config.displayName} admin Flutter web application.'),
  );
  _replaceExact(
    repositoryRoot,
    pendingSources,
    'apps/admin_app/web/index.html',
    previous?.adminDisplayName ?? 'Admin Panel',
    _htmlEscape(config.adminDisplayName),
  );
  _replaceExact(
    repositoryRoot,
    pendingSources,
    'apps/admin_app/web/index.html',
    previous == null
        ? 'Web administration panel.'
        : '${_htmlEscape(previous.displayName)} administration panel.',
    '${_htmlEscape(config.displayName)} administration panel.',
  );

  const webManifestPath = 'apps/admin_app/web/manifest.json';
  final webManifestSource = _pendingOrCurrent(
    repositoryRoot,
    pendingSources,
    webManifestPath,
  );
  final webManifest = jsonDecode(webManifestSource);
  if (webManifest is! Map<String, dynamic>) {
    throw const BootstrapException(
      'apps/admin_app/web/manifest.json must contain a JSON object.',
    );
  }
  webManifest
    ..['name'] = config.adminDisplayName
    ..['short_name'] = '${config.displayName} Admin'
    ..['description'] = '${config.displayName} administration panel.';
  pendingSources[webManifestPath] =
      '${const JsonEncoder.withIndent('    ').convert(webManifest)}\n';

  for (final locale in ['en', 'kk', 'ru']) {
    final path = 'apps/admin_app/lib/l10n/admin_app_$locale.arb';
    final source = _pendingOrCurrent(repositoryRoot, pendingSources, path);
    final pattern = RegExp(r'"adminAppTitle"\s*:\s*"[^"]*"');
    if (!pattern.hasMatch(source)) {
      throw BootstrapException('$path does not define adminAppTitle.');
    }
    pendingSources[path] = source.replaceFirst(
      pattern,
      '"adminAppTitle": ${jsonEncode(config.adminDisplayName)}',
    );
  }

  final fileChanges = pendingSources.entries
      .map((entry) {
        final file = File.fromUri(repositoryRoot.uri.resolve(entry.key));
        final before = file.readAsStringSync();
        return BootstrapFileChange(
          relativePath: entry.key,
          before: before,
          after: entry.value,
        );
      })
      .where((change) => change.before != change.after)
      .toList();
  final configurationChange = _projectConfigurationChange(
    repositoryRoot,
    configurationPath,
    config,
  );
  if (configurationChange.before != configurationChange.after) {
    fileChanges.add(configurationChange);
  }
  fileChanges.sort((first, second) {
    return first.relativePath.compareTo(second.relativePath);
  });

  return BootstrapPlan(
    repositoryRoot: repositoryRoot,
    fileChanges: fileChanges,
    mainActivityMove: sourceActivityPath == targetActivityPath
        ? null
        : BootstrapFileMove(
            sourceRelativePath: sourceActivityPath,
            targetRelativePath: targetActivityPath,
          ),
  );
}

BootstrapFileChange _projectConfigurationChange(
  Directory repositoryRoot,
  String relativePath,
  BootstrapConfig config,
) {
  final file = File.fromUri(repositoryRoot.uri.resolve(relativePath));
  final before = file.existsSync() ? file.readAsStringSync() : null;
  final fields = <String, String>{
    'name': config.projectName,
    'display_name': config.displayName,
    'organization': config.organization,
    'application_id': config.applicationId,
    'ios_team': config.iosTeam,
  };
  final buffer = StringBuffer()
    ..writeln('# Edit the top-level values, then run:')
    ..writeln('# dart run tool/generation/bootstrap_project.dart')
    ..writeln('# The applied section is maintained by the script.');
  for (final entry in fields.entries) {
    buffer.writeln('${entry.key}: ${jsonEncode(entry.value)}');
  }
  buffer.writeln('applied:');
  for (final entry in fields.entries) {
    buffer.writeln('  ${entry.key}: ${jsonEncode(entry.value)}');
  }

  return BootstrapFileChange(
    relativePath: relativePath,
    before: before,
    after: buffer.toString(),
  );
}

Iterable<File> _textFilesUnder(Directory root, String relativeRoot) sync* {
  final directory = Directory.fromUri(root.uri.resolve('$relativeRoot/'));
  if (!directory.existsSync()) return;

  for (final entity in directory.listSync(
    recursive: true,
    followLinks: false,
  )) {
    if (entity is! File) continue;
    final path = entity.path.replaceAll(r'\', '/');
    if (path.contains('/.dart_tool/') ||
        path.contains('/build/') ||
        path.contains('/.gradle/') ||
        path.contains('/Pods/') ||
        _isBinaryFile(path)) {
      continue;
    }
    yield entity;
  }
}

bool _isBinaryFile(String path) {
  return RegExp(
    r'\.(?:aab|apk|gif|ico|jar|jpeg|jpg|jks|keystore|p12|p8|png|ttf|zip)$',
    caseSensitive: false,
  ).hasMatch(path);
}

void _replaceExact(
  Directory root,
  Map<String, String> pendingSources,
  String relativePath,
  String from,
  String to,
) {
  final source = _pendingOrCurrent(root, pendingSources, relativePath);
  if (!source.contains(from)) {
    throw BootstrapException(
      'Expected template value was not found in $relativePath: $from',
    );
  }
  pendingSources[relativePath] = source.replaceAll(from, to);
}

String _pendingOrCurrent(
  Directory root,
  Map<String, String> pendingSources,
  String relativePath,
) {
  final pending = pendingSources[relativePath];
  if (pending != null) return pending;
  final file = File.fromUri(root.uri.resolve(relativePath));
  if (!file.existsSync()) {
    throw BootstrapException(
      'Required template file is missing: $relativePath',
    );
  }
  return file.readAsStringSync();
}

String _relativePath(Directory root, File file) {
  return file.uri.path.substring(root.uri.path.length);
}

int _countOccurrences(String source, String pattern) {
  return source.split(pattern).length - 1;
}

String _xmlEscape(String value) {
  return value
      .replaceAll('&', '&amp;')
      .replaceAll('"', '&quot;')
      .replaceAll('<', '&lt;')
      .replaceAll('>', '&gt;');
}

String _htmlEscape(String value) => _xmlEscape(value);

String _pubspecDescription(String value) => 'description: ${jsonEncode(value)}';

void _deleteEmptyAndroidPackageDirectories(
  Directory root,
  String sourceActivityPath,
) {
  final kotlinRoot = Directory.fromUri(
    root.uri.resolve('apps/client_app/android/app/src/main/kotlin/'),
  );
  var directory = File.fromUri(root.uri.resolve(sourceActivityPath)).parent;
  while (directory.path != kotlinRoot.path &&
      directory.path.startsWith(kotlinRoot.path) &&
      directory.existsSync() &&
      directory.listSync().isEmpty) {
    final parent = directory.parent;
    directory.deleteSync();
    directory = parent;
  }
}

String _toDisplayName(String value) {
  return value
      .split('_')
      .map((part) => '${part[0].toUpperCase()}${part.substring(1)}')
      .join(' ');
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
  if (result != 0) {
    throw BootstrapException(
      '$executable ${arguments.join(' ')} failed with exit code $result.',
    );
  }
}

Directory findRepositoryRoot() {
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
      throw BootstrapException(
        'Could not find the repository root from ${Directory.current.path}.',
      );
    }
    current = parent;
  }
}

Directory resolveRepositoryRoot(String path) {
  final directory = Directory(path).absolute;
  if (!directory.existsSync()) {
    throw BootstrapException('Repository root does not exist: $path');
  }
  return Directory(directory.resolveSymbolicLinksSync());
}

void validateRepositoryRoot(Directory root) {
  final pubspec = File.fromUri(root.uri.resolve('pubspec.yaml'));
  final modules = Directory.fromUri(root.uri.resolve('modules/'));
  if (!pubspec.existsSync() || !modules.existsSync()) {
    throw BootstrapException(
      'Not a supported workspace root: ${root.path}',
    );
  }
}

_BootstrapOptions _parseArguments(List<String> arguments) {
  var configurationPath = 'project.yaml';
  String? repositoryRoot;
  var dryRun = false;
  var runCodegen = true;

  for (var index = 0; index < arguments.length; index++) {
    final argument = arguments[index];
    switch (argument) {
      case '-h' || '--help':
        return const _BootstrapOptions(showHelp: true);
      case '--config':
        configurationPath = _optionValue(arguments, ++index, argument);
      case '--root':
        repositoryRoot = _optionValue(arguments, ++index, argument);
      case '--dry-run':
        dryRun = true;
      case '--no-codegen':
        runCodegen = false;
      default:
        throw BootstrapException('Unknown argument: $argument');
    }
  }

  return _BootstrapOptions(
    configurationPath: configurationPath,
    repositoryRoot: repositoryRoot,
    dryRun: dryRun,
    runCodegen: runCodegen,
  );
}

String _optionValue(List<String> arguments, int index, String option) {
  if (index >= arguments.length || arguments[index].startsWith('-')) {
    throw BootstrapException('$option requires a value.');
  }
  return arguments[index];
}

final class _BootstrapOptions {
  const _BootstrapOptions({
    this.configurationPath = 'project.yaml',
    this.repositoryRoot,
    this.dryRun = false,
    this.runCodegen = true,
    this.showHelp = false,
  });

  final String configurationPath;
  final String? repositoryRoot;
  final bool dryRun;
  final bool runCodegen;
  final bool showHelp;
}

final class BootstrapException implements Exception {
  const BootstrapException(this.message);

  final String message;

  @override
  String toString() => message;
}
