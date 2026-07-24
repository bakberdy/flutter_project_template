import 'dart:convert';
import 'dart:io';

import 'package:test/test.dart';

import '../../../tool/generation/bootstrap_project.dart';

void main() {
  late Directory repository;

  setUp(() {
    repository = Directory.systemTemp.createTempSync('bootstrap_project_');
    _createTemplateFixture(repository);
  });

  tearDown(() {
    if (repository.existsSync()) {
      repository.deleteSync(recursive: true);
    }
  });

  test('updates product identity and moves the Android activity', () {
    final config = BootstrapConfig(
      projectName: 'my_app',
      displayName: 'My Product',
      organization: 'com.acme',
      iosTeam: 'ABCDE12345',
    );

    final plan = createBootstrapPlan(repository, config);

    expect(config.applicationId, 'com.acme.myapp');
    expect(
      plan.fileChanges.map((change) => change.relativePath),
      contains('project.json'),
    );

    plan.apply();

    expect(
      _read(repository, 'apps/client_app/android/app/build.gradle.kts'),
      contains('com.acme.myapp'),
    );
    expect(
      _read(
        repository,
        'apps/client_app/android/app/src/main/AndroidManifest.xml',
      ),
      contains('android:label="My Product"'),
    );
    expect(
      File.fromUri(
        repository.uri.resolve(
          'apps/client_app/android/app/src/main/kotlin/'
          'com/example/client_app/MainActivity.kt',
        ),
      ).existsSync(),
      isFalse,
    );
    expect(
      _read(
        repository,
        'apps/client_app/android/app/src/main/kotlin/'
        'com/acme/myapp/MainActivity.kt',
      ),
      contains('package com.acme.myapp'),
    );
    expect(
      _read(repository, 'apps/client_app/ios/Runner/Info.plist'),
      allOf(
        contains('<string>My Product</string>'),
        contains('<string>my_app</string>'),
      ),
    );
    expect(
      _read(repository, 'apps/client_app/ios/Flutter/Debug.xcconfig'),
      contains('com.acme.myapp'),
    );
    expect(
      _read(repository, 'apps/client_app/ios/fastlane/Appfile'),
      allOf(contains('com.acme.myapp'), contains('ABCDE12345')),
    );
    expect(
      _read(repository, '.github/workflows/release.yml'),
      allOf(contains('com.acme.myapp'), contains('ABCDE12345')),
    );
    expect(
      _read(repository, 'apps/admin_app/web/index.html'),
      contains('My Product Admin'),
    );
    expect(
      jsonDecode(_read(repository, 'apps/admin_app/web/manifest.json')),
      containsPair('name', 'My Product Admin'),
    );
    for (final locale in ['en', 'kk', 'ru']) {
      expect(
        jsonDecode(
          _read(
            repository,
            'apps/admin_app/lib/l10n/admin_app_$locale.arb',
          ),
        ),
        containsPair('adminAppTitle', 'My Product Admin'),
      );
    }
    expect(
      _read(
        repository,
        'apps/admin_app/lib/gen/l10n/admin_app_localizations_en.dart',
      ),
      contains('Admin Panel'),
      reason: 'Generated localization must be updated by flutter gen-l10n.',
    );

    final metadata =
        jsonDecode(_read(repository, 'project.json')) as Map<String, dynamic>;
    expect(metadata, {
      'name': 'my_app',
      'display_name': 'My Product',
      'organization': 'com.acme',
      'application_id': 'com.acme.myapp',
      'ios_team': 'ABCDE12345',
    });
  });

  test('derives a display name and validates identity inputs', () {
    final config = BootstrapConfig(
      projectName: 'sample_bank',
      organization: 'kz.example',
      iosTeam: '1A2B3C4D5E',
    );

    expect(config.displayName, 'Sample Bank');
    expect(config.applicationId, 'kz.example.samplebank');

    expect(
      () => BootstrapConfig(
        projectName: 'SampleBank',
        organization: 'kz.example',
        iosTeam: '1A2B3C4D5E',
      ),
      throwsA(isA<BootstrapException>()),
    );
    expect(
      () => BootstrapConfig(
        projectName: 'sample_bank',
        organization: 'example',
        iosTeam: '1A2B3C4D5E',
      ),
      throwsA(isA<BootstrapException>()),
    );
    expect(
      () => BootstrapConfig(
        projectName: 'sample_bank',
        organization: 'kz.example',
        iosTeam: 'invalid',
      ),
      throwsA(isA<BootstrapException>()),
    );
  });
}

void _createTemplateFixture(Directory repository) {
  _write(repository, 'pubspec.yaml', 'workspace:\n  - modules/core\n');
  Directory.fromUri(
    repository.uri.resolve('modules/core/'),
  ).createSync(recursive: true);

  _write(
    repository,
    'apps/client_app/android/app/build.gradle.kts',
    'namespace = "com.example.client_app"\n'
        'applicationId = "com.example.client_app"\n',
  );
  _write(
    repository,
    'apps/client_app/android/app/src/main/AndroidManifest.xml',
    '<application android:label="client_app"></application>\n',
  );
  _write(
    repository,
    'apps/client_app/android/app/src/main/kotlin/'
        'com/example/client_app/MainActivity.kt',
    'package com.example.client_app\n',
  );
  _write(
    repository,
    'apps/client_app/ios/Flutter/Debug.xcconfig',
    'PRODUCT_BUNDLE_IDENTIFIER=com.example.clientApp\n',
  );
  _write(
    repository,
    'apps/client_app/ios/Runner/Info.plist',
    '<string>Client App</string>\n<string>client_app</string>\n',
  );
  _write(
    repository,
    'apps/client_app/ios/fastlane/Appfile',
    'app_identifier("com.example.clientApp")\n'
        'team_id("C466ZHPP34")\n',
  );
  _write(
    repository,
    'apps/client_app/README.md',
    '# client_app\n\nA new Flutter project.\n',
  );
  _write(
    repository,
    'apps/client_app/pubspec.yaml',
    'name: client_app\n'
        'description: Client Flutter application.\n',
  );
  _write(
    repository,
    'apps/admin_app/README.md',
    '# admin_app\n\nFlutter web administration panel.\n',
  );
  _write(
    repository,
    'apps/admin_app/pubspec.yaml',
    'name: admin_app\n'
        'description: Admin Flutter web application.\n',
  );
  _write(
    repository,
    '.github/workflows/release.yml',
    'APP_ID: com.example.client_app\n'
        'IOS_ID: com.example.clientApp\n'
        'IOS_TEAM: C466ZHPP34\n',
  );
  _write(
    repository,
    'apps/admin_app/web/index.html',
    '<title>Admin Panel</title>\n'
        '<meta content="Web administration panel.">\n',
  );
  _write(
    repository,
    'apps/admin_app/web/manifest.json',
    '''
{
  "name": "Admin Panel",
  "short_name": "Admin",
  "description": "Web administration panel."
}
''',
  );
  for (final locale in ['en', 'kk', 'ru']) {
    _write(
      repository,
      'apps/admin_app/lib/l10n/admin_app_$locale.arb',
      '{"@@locale":"$locale","adminAppTitle":"Admin Panel"}\n',
    );
  }
  _write(
    repository,
    'apps/admin_app/lib/gen/l10n/admin_app_localizations_en.dart',
    "String get adminAppTitle => 'Admin Panel';\n",
  );
}

void _write(Directory root, String relativePath, String contents) {
  final file = File.fromUri(root.uri.resolve(relativePath));
  file.parent.createSync(recursive: true);
  file.writeAsStringSync(contents);
}

String _read(Directory root, String relativePath) {
  return File.fromUri(root.uri.resolve(relativePath)).readAsStringSync();
}
