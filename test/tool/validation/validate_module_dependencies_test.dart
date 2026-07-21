import 'dart:io';

import 'package:test/test.dart';

import '../../../tool/validation/validate_module_dependencies.dart';

void main() {
  group('ModuleDependencyValidator', () {
    test('accepts valid module dependencies', () {
      final violations = _validate(
        dependencies: {
          'feature_a': {'core', 'design_system', 'shared'},
          'shared': {'core', 'design_system'},
        },
      );

      expect(violations, isEmpty);
    });

    test('rejects a feature-to-feature dependency', () {
      final violations = _validate(
        dependencies: {
          'feature_a': {'feature_b'},
        },
      );

      expect(violations, hasLength(1));
      expect(violations.single.moduleName, 'feature_a');
      expect(violations.single.dependencyName, 'feature_b');
    });

    test('accepts a dependency from an allowed group', () {
      final violations = _validate(
        dependencies: {
          'feature_a': {'design_system'},
        },
      );

      expect(violations, isEmpty);
    });

    test('rejects a dependency when no groups are allowed', () {
      final violations = _validate(
        dependencies: {
          'core': {'shared'},
        },
      );

      expect(violations, hasLength(1));
      expect(violations.single.allowedDependencies, isEmpty);
    });

    test('ignores external dependencies', () {
      final violations = _validate(
        dependencies: {
          'core': {'dio', 'flutter_bloc', 'freezed'},
        },
      );

      expect(violations, isEmpty);
    });

    test('skips dependency rules when validation is disabled', () {
      final violations = _validate(
        dependenciesEnabled: false,
        dependencies: {
          'feature_a': {'feature_b'},
          'core': {'shared'},
        },
      );

      expect(violations, isEmpty);
    });

    test('reports multiple violations in deterministic order', () {
      final violations = _validate(
        dependencies: {
          'feature_b': {'feature_a'},
          'feature_a': {'feature_b'},
          'core': {'shared'},
        },
      );

      expect(
        violations
            .map(
              (violation) =>
                  '${violation.moduleName}->'
                  '${violation.dependencyName}',
            )
            .toList(),
        ['core->shared', 'feature_a->feature_b', 'feature_b->feature_a'],
      );
    });

    test('rejects a self-dependency', () {
      final violations = _validate(
        dependencies: {
          'feature_a': {'feature_a'},
        },
      );

      expect(violations, hasLength(1));
      expect(violations.single.dependencyName, 'feature_a');
    });
  });

  group('ArchitectureConfigParser', () {
    test('rejects an unknown group in allow.groups', () {
      final result = ArchitectureConfigParser().parse(
        _singleModuleArchitecture(allowedGroups: ['missing']),
      );

      expect(result.config, isNull);
      expect(
        result.violations.map((violation) => violation.message),
        contains('Unknown group "missing".'),
      );
    });

    test('rejects an unknown module inside a group', () {
      final result = ArchitectureConfigParser().parse(
        _singleModuleArchitecture(groupModules: ['core', 'missing']),
      );

      expect(result.config, isNull);
      expect(
        result.violations.map((violation) => violation.message),
        contains('Unknown module "missing".'),
      );
    });

    test('reports malformed configuration without throwing', () {
      final result = ArchitectureConfigParser().parse('version: [');

      expect(result.config, isNull);
      expect(result.violations, hasLength(1));
      expect(result.violations.single.message, startsWith('Invalid YAML:'));
    });
  });

  group('ModulePubspecParser', () {
    test('collects dependencies from all supported pubspec sections', () {
      final result = ModulePubspecParser().parse(
        '''
name: core
dependencies:
  shared: any
dev_dependencies:
  feature_a: any
dependency_overrides:
  design_system: any
''',
        sourceName: 'modules/core/pubspec.yaml',
      );

      expect(result.violations, isEmpty);
      expect(
        result.pubspec!.dependencies,
        {'shared', 'feature_a', 'design_system'},
      );
    });
  });

  group('filesystem validation', () {
    late Directory repositoryRoot;

    setUp(() {
      repositoryRoot = Directory.systemTemp.createTempSync(
        'module_dependency_validator_test_',
      );
    });

    tearDown(() {
      repositoryRoot.deleteSync(recursive: true);
    });

    test('reports a missing architecture.yaml', () {
      final result = validateArchitecture(repositoryRoot);

      expect(result.configViolations, hasLength(1));
      expect(
        result.configViolations.single.message,
        'Configuration file does not exist.',
      );
    });

    test('reports a missing module directory', () {
      _writeArchitecture(repositoryRoot);

      final result = validateArchitecture(repositoryRoot);

      expect(result.configViolations, hasLength(1));
      expect(
        result.configViolations.single.message,
        'Configured module directory does not exist.',
      );
    });

    test('reports a missing module pubspec', () {
      _writeArchitecture(repositoryRoot);
      Directory('${repositoryRoot.path}/modules/core').createSync(
        recursive: true,
      );

      final result = validateArchitecture(repositoryRoot);

      expect(result.configViolations, hasLength(1));
      expect(
        result.configViolations.single.message,
        'Module pubspec.yaml does not exist.',
      );
    });

    test('reports a package name mismatch', () {
      _writeArchitecture(repositoryRoot);
      _writePubspec(repositoryRoot, packageName: 'different_name');

      final result = validateArchitecture(repositoryRoot);

      expect(result.configViolations, hasLength(1));
      expect(
        result.configViolations.single.message,
        contains('does not match configured module name "core"'),
      );
    });

    test('passes when dependency validation is disabled', () {
      _writeArchitecture(repositoryRoot, dependenciesEnabled: false);
      _writePubspec(
        repositoryRoot,
        packageName: 'core',
        dependencies: const ['core'],
      );

      final result = validateArchitecture(repositoryRoot);

      expect(result.configViolations, isEmpty);
      expect(result.dependencyViolations, isEmpty);
      expect(result.checkedModuleCount, 1);
    });
  });
}

List<DependencyViolation> _validate({
  required Map<String, Set<String>> dependencies,
  bool dependenciesEnabled = true,
}) {
  final config = _config(dependenciesEnabled: dependenciesEnabled);
  final pubspecs = <String, ModulePubspec>{};
  for (final moduleName in config.modules.keys) {
    pubspecs[moduleName] = ModulePubspec(
      name: moduleName,
      dependencies: dependencies[moduleName] ?? const {},
    );
  }
  return ModuleDependencyValidator().validate(config, pubspecs);
}

ArchitectureConfig _config({required bool dependenciesEnabled}) {
  const groups = <String, GroupConfig>{
    'core': GroupConfig(name: 'core', modules: ['core']),
    'ui': GroupConfig(name: 'ui', modules: ['design_system']),
    'shared': GroupConfig(name: 'shared', modules: ['shared']),
    'features': GroupConfig(
      name: 'features',
      modules: ['feature_a', 'feature_b'],
    ),
  };
  const modules = <String, ModuleConfig>{
    'core': ModuleConfig(
      name: 'core',
      path: 'modules/core',
      allowedGroups: [],
    ),
    'design_system': ModuleConfig(
      name: 'design_system',
      path: 'modules/design_system',
      allowedGroups: [],
    ),
    'shared': ModuleConfig(
      name: 'shared',
      path: 'modules/shared',
      allowedGroups: ['core', 'ui'],
    ),
    'feature_a': ModuleConfig(
      name: 'feature_a',
      path: 'modules/feature_a',
      allowedGroups: ['core', 'ui', 'shared'],
    ),
    'feature_b': ModuleConfig(
      name: 'feature_b',
      path: 'modules/feature_b',
      allowedGroups: ['core', 'ui', 'shared'],
    ),
  };

  return ArchitectureConfig(
    version: 1,
    groups: groups,
    modules: modules,
    rules: RulesConfig(
      dependencies: DependencyRulesConfig(enabled: dependenciesEnabled),
      importsEnabled: false,
      relativeImportsEnabled: false,
      circularDependenciesEnabled: false,
    ),
  );
}

String _singleModuleArchitecture({
  List<String> groupModules = const ['core'],
  List<String> allowedGroups = const [],
}) {
  final groupModuleYaml = groupModules
      .map((module) => '    - $module')
      .join('\n');
  final allowedGroupYaml = allowedGroups.isEmpty
      ? '      groups: []'
      : '      groups:\n'
            '${allowedGroups.map((group) => '        - $group').join('\n')}';
  return '''
version: 1
groups:
  core:
$groupModuleYaml
modules:
  core:
    path: modules/core
    allow:
$allowedGroupYaml
rules:
  dependencies:
    enabled: true
  imports:
    enabled: false
  relative_imports:
    enabled: false
  circular_dependencies:
    enabled: false
''';
}

void _writeArchitecture(
  Directory repositoryRoot, {
  bool dependenciesEnabled = true,
}) {
  File('${repositoryRoot.path}/architecture.yaml').writeAsStringSync(
    _singleModuleArchitecture().replaceFirst(
      'dependencies:\n    enabled: true',
      'dependencies:\n    enabled: $dependenciesEnabled',
    ),
  );
}

void _writePubspec(
  Directory repositoryRoot, {
  required String packageName,
  List<String> dependencies = const [],
}) {
  final moduleDirectory = Directory('${repositoryRoot.path}/modules/core')
    ..createSync(recursive: true);
  final dependencyLines = dependencies
      .map((dependency) => '  $dependency: any')
      .join('\n');
  File('${moduleDirectory.path}/pubspec.yaml').writeAsStringSync('''
name: $packageName
dependencies:
$dependencyLines
''');
}
