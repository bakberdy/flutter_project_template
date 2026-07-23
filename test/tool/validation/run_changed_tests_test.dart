import 'dart:io';

import 'package:test/test.dart';

import '../../../tool/validation/run_changed_tests.dart';

void main() {
  late Directory repository;

  setUp(() {
    repository = Directory.systemTemp.createTempSync(
      'changed_test_packages_',
    );
  });

  tearDown(() {
    if (repository.existsSync()) {
      repository.deleteSync(recursive: true);
    }
  });

  test('returns each changed testable package once in sorted order', () {
    _createPackage(repository, 'modules/shared');
    _createPackage(repository, 'apps/client_app');
    _createPackage(repository, 'packages/project_lints');

    final result = testPackagePathsForChangedFiles(repository, [
      'modules/shared/lib/shared.dart',
      'apps/client_app/test/app_test.dart',
      'modules/shared/test/shared_test.dart',
      'packages/project_lints/lib/main.dart',
    ]);

    expect(result, [
      'apps/client_app',
      'modules/shared',
      'packages/project_lints',
    ]);
  });

  test('ignores unrelated files and packages without tests', () {
    _createPackage(repository, 'modules/core', withTests: false);

    final result = testPackagePathsForChangedFiles(repository, [
      'README.md',
      'docs/architecture/workspace_structure.md',
      'modules/core/lib/core.dart',
      'tool/validation/run_changed_tests.dart',
    ]);

    expect(result, isEmpty);
  });
}

void _createPackage(
  Directory repository,
  String path, {
  bool withTests = true,
}) {
  final package = Directory.fromUri(repository.uri.resolve('$path/'))
    ..createSync(recursive: true);
  File.fromUri(package.uri.resolve('pubspec.yaml')).writeAsStringSync(
    'name: ${path.replaceAll('/', '_')}\n',
  );
  if (withTests) {
    Directory.fromUri(package.uri.resolve('test/')).createSync();
  }
}
