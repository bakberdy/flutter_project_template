import 'dart:convert';
import 'dart:io';

import 'package:yaml/yaml.dart';

Future<void> main(List<String> arguments) async {
  final repositoryRoot = _findRepositoryRoot();
  final baseRevision = await _baseRevision(repositoryRoot, arguments);
  final changedFiles = await _changedFiles(repositoryRoot, baseRevision);
  final packagePaths = testPackagePathsForChangedFiles(
    repositoryRoot,
    changedFiles,
  );

  if (packagePaths.isEmpty) {
    stdout.writeln('No changed packages with tests.');
    return;
  }

  stdout
    ..writeln('Changed packages with tests:')
    ..writeln(packagePaths.map((path) => '- $path').join('\n'));

  for (final packagePath in packagePaths) {
    final packageDirectory = Directory.fromUri(
      repositoryRoot.uri.resolve('$packagePath/'),
    );
    final pubspec = loadYaml(
      File.fromUri(
        packageDirectory.uri.resolve('pubspec.yaml'),
      ).readAsStringSync(),
    );
    final dependencies = pubspec is YamlMap ? pubspec['dependencies'] : null;
    final isFlutterPackage =
        dependencies is YamlMap && dependencies.containsKey('flutter');

    stdout.writeln('\n==> $packagePath');
    if (isFlutterPackage) {
      await _run(
        'flutter',
        const ['test'],
        workingDirectory: packageDirectory.path,
      );
    } else {
      await _run(
        'dart',
        const ['pub', 'get'],
        workingDirectory: packageDirectory.path,
      );
      await _run(
        'dart',
        const ['test'],
        workingDirectory: packageDirectory.path,
      );
    }
  }

  stdout.writeln('\nAll changed-package tests passed.');
}

List<String> testPackagePathsForChangedFiles(
  Directory repositoryRoot,
  Iterable<String> changedFiles,
) {
  final packagePaths = <String>{};

  for (final changedFile in changedFiles) {
    final segments = changedFile.replaceAll(r'\', '/').split('/');
    if (segments.length < 3 ||
        !const {'apps', 'modules', 'packages'}.contains(segments.first)) {
      continue;
    }

    final packagePath = '${segments[0]}/${segments[1]}';
    final packageDirectory = Directory.fromUri(
      repositoryRoot.uri.resolve('$packagePath/'),
    );
    if (File.fromUri(
          packageDirectory.uri.resolve('pubspec.yaml'),
        ).existsSync() &&
        Directory.fromUri(packageDirectory.uri.resolve('test/')).existsSync()) {
      packagePaths.add(packagePath);
    }
  }

  return packagePaths.toList()..sort();
}

Future<String> _baseRevision(
  Directory repositoryRoot,
  List<String> arguments,
) async {
  String? configuredBase;
  for (var index = 0; index < arguments.length; index++) {
    if (arguments[index] != '--base') continue;
    if (index + 1 >= arguments.length) {
      _usageError('Missing value after --base.');
    }
    configuredBase = arguments[index + 1].trim();
    index++;
  }

  if (configuredBase != null &&
      configuredBase.isNotEmpty &&
      !RegExp(r'^0+$').hasMatch(configuredBase)) {
    return configuredBase;
  }

  final result = await Process.run(
    'git',
    const ['rev-parse', 'HEAD^'],
    workingDirectory: repositoryRoot.path,
  );
  if (result.exitCode != 0) {
    stderr.write(result.stderr);
    _usageError('Could not determine a base revision.');
  }
  return (result.stdout as String).trim();
}

Future<List<String>> _changedFiles(
  Directory repositoryRoot,
  String baseRevision,
) async {
  final result = await Process.run(
    'git',
    [
      'diff',
      '--name-only',
      '--diff-filter=ACMRT',
      '-z',
      '$baseRevision...HEAD',
    ],
    workingDirectory: repositoryRoot.path,
    stdoutEncoding: utf8,
  );
  if (result.exitCode != 0) {
    stderr.write(result.stderr);
    exit(result.exitCode);
  }

  return (result.stdout as String)
      .split('\u0000')
      .where((path) => path.isNotEmpty)
      .toList();
}

Future<void> _run(
  String executable,
  List<String> arguments, {
  required String workingDirectory,
}) async {
  final process = await Process.start(
    executable,
    arguments,
    workingDirectory: workingDirectory,
    mode: ProcessStartMode.inheritStdio,
  );
  final result = await process.exitCode;
  if (result != 0) exit(result);
}

Directory _findRepositoryRoot() {
  var current = Directory.current.absolute;
  while (true) {
    final pubspec = File.fromUri(current.uri.resolve('pubspec.yaml'));
    final modules = Directory.fromUri(current.uri.resolve('modules/'));
    if (pubspec.existsSync() && modules.existsSync()) return current;

    final parent = current.parent;
    if (parent.path == current.path) {
      _usageError('Could not find the repository root.');
    }
    current = parent;
  }
}

Never _usageError(String message) {
  stderr
    ..writeln(message)
    ..writeln(
      'Usage: dart run tool/validation/run_changed_tests.dart '
      '[--base <git-revision>]',
    );
  exit(64);
}
