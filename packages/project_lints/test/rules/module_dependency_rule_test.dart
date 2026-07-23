import 'package:analyzer_testing/analysis_rule/analysis_rule.dart';
import 'package:project_lints/project_lints.dart';
import 'package:test/test.dart';

void main() {
  late _ModuleDependencyRuleTest testHarness;

  setUp(() {
    testHarness = _ModuleDependencyRuleTest()..setUp();
  });
  tearDown(() => testHarness.tearDown());

  test(
    'allows a dependency from an allowed group',
    () => testHarness.allowsDependencyFromAllowedGroup(),
  );
  test(
    'rejects a feature module dependency',
    () => testHarness.rejectsFeatureModuleDependency(),
  );
}

class _ModuleDependencyRuleTest extends AnalysisRuleTest {
  @override
  void setUp() {
    rule = ModuleDependencyRule(policyResolver: (_) => _policy());
    super.setUp();
  }

  Future<void> allowsDependencyFromAllowedGroup() async {
    await assertNoPubspecDiagnostics('''
name: test
dependencies:
  core: any
''');
  }

  Future<void> rejectsFeatureModuleDependency() async {
    await assertPubspecDiagnostics(
      '''
name: test
dependencies:
  other_feature: any
''',
      [
        lint(
          27,
          13,
          messageContainsAll: ['test', 'other_feature'],
          correctionContains: 'core',
        ),
      ],
    );
  }
}

ArchitecturePolicy _policy() {
  const groups = <String, GroupConfig>{
    'core': GroupConfig(name: 'core', modules: ['core']),
    'features': GroupConfig(
      name: 'features',
      modules: ['test', 'other_feature'],
    ),
  };
  const modules = <String, ModuleConfig>{
    'core': ModuleConfig(name: 'core', path: 'core', allowedGroups: []),
    'test': ModuleConfig(name: 'test', path: 'test', allowedGroups: ['core']),
    'other_feature': ModuleConfig(
      name: 'other_feature',
      path: 'other_feature',
      allowedGroups: ['core'],
    ),
  };
  return const ArchitecturePolicy(
    repositoryRoot: '/home',
    config: ArchitectureConfig(
      version: 1,
      groups: groups,
      modules: modules,
      rules: RulesConfig(
        dependencies: DependencyRulesConfig(enabled: true),
        importsEnabled: true,
        relativeImportsEnabled: false,
        circularDependenciesEnabled: false,
      ),
    ),
  );
}
