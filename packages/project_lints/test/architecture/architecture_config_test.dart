import 'package:project_lints/project_lints.dart';
import 'package:test/test.dart';

void main() {
  group('ArchitectureConfigParser', () {
    test('rejects an unknown group in allow.groups', () {
      final result = ArchitectureConfigParser().parse(
        _architecture(allowedGroups: ['missing']),
      );

      expect(result.config, isNull);
      expect(
        result.violations.map((violation) => violation.message),
        contains('Unknown group "missing".'),
      );
    });

    test('rejects an unknown module inside a group', () {
      final result = ArchitectureConfigParser().parse(
        _architecture(groupModules: ['core', 'missing']),
      );

      expect(result.config, isNull);
      expect(
        result.violations.map((violation) => violation.message),
        contains('Unknown module "missing".'),
      );
    });

    test('reports malformed YAML', () {
      final result = ArchitectureConfigParser().parse('version: [');

      expect(result.config, isNull);
      expect(result.violations, hasLength(1));
      expect(result.violations.single.message, startsWith('Invalid YAML:'));
    });
  });
}

String _architecture({
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
    enabled: true
  relative_imports:
    enabled: false
  circular_dependencies:
    enabled: false
''';
}
