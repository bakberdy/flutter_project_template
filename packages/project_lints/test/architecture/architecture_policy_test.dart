import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:project_lints/project_lints.dart';
import 'package:test/test.dart';

void main() {
  group('ArchitecturePolicyLoader', () {
    late Directory repository;
    late File configFile;
    late String sourcePath;

    setUp(() {
      repository = Directory.systemTemp.createTempSync(
        'project_lints_policy_',
      );
      configFile = File(p.join(repository.path, 'architecture.yaml'))
        ..writeAsStringSync(_architecture);
      sourcePath = p.join(
        repository.path,
        'modules',
        'core',
        'lib',
        'src',
        'example.dart',
      );
    });

    tearDown(() {
      if (repository.existsSync()) {
        repository.deleteSync(recursive: true);
      }
    });

    test('reuses an ancestor lookup for nested directories', () {
      final loader = ArchitecturePolicyLoader();

      final first = loader.resolve(sourcePath);
      final second = loader.resolve(
        p.join(p.dirname(sourcePath), 'nested', 'other.dart'),
      );

      expect(first, isNotNull);
      expect(second, same(first));
    });

    test('invalidates cached paths when the config is deleted', () {
      final loader = ArchitecturePolicyLoader();

      expect(loader.resolve(sourcePath), isNotNull);
      configFile.deleteSync();

      expect(loader.resolve(sourcePath), isNull);
    });

    test('caches paths that have no architecture config', () {
      final loader = ArchitecturePolicyLoader();
      final unrelatedDirectory = Directory.systemTemp.createTempSync(
        'project_lints_without_config_',
      );
      addTearDown(() {
        if (unrelatedDirectory.existsSync()) {
          unrelatedDirectory.deleteSync(recursive: true);
        }
      });
      final unrelatedPath = p.join(
        unrelatedDirectory.path,
        'lib',
        'example.dart',
      );

      expect(loader.resolve(unrelatedPath), isNull);
      expect(loader.resolve(unrelatedPath), isNull);
    });
  });
}

const _architecture = '''
version: 1
groups:
  core:
    - core
modules:
  core:
    path: modules/core
    allow:
      groups: []
rules:
  dependencies:
    enabled: true
  imports:
    enabled: true
  relative_imports:
    enabled: false
  circular_dependencies:
    enabled: false
''';
