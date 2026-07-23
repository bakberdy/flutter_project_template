import 'package:analyzer_testing/analysis_rule/analysis_rule.dart';
import 'package:project_lints/project_lints.dart';
import 'package:test/test.dart';

void main() {
  late _CommonFeatureImportRuleTest testHarness;

  tearDown(() => testHarness.tearDown());

  test('rejects a feature import from common code', () async {
    testHarness = _CommonFeatureImportRuleTest()..setUp();
    await testHarness.rejectsFeatureImport();
  });

  test('allows feature composition from common config', () async {
    testHarness = _CommonFeatureImportRuleTest(configSource: true)..setUp();
    await testHarness.allowsConfigFeatureImport();
  });
}

class _CommonFeatureImportRuleTest extends AnalysisRuleTest {
  _CommonFeatureImportRuleTest({this.configSource = false});

  final bool configSource;

  @override
  String get testFileName =>
      configSource ? 'src/common/config/router.dart' : 'src/common/widget.dart';

  @override
  void setUp() {
    rule = CommonFeatureImportRule(policyResolver: (_) => _policy());
    super.setUp();
    newFile(
      '$testPackageLibPath/src/features/profile/profile.dart',
      'class Profile {}',
    );
  }

  Future<void> rejectsFeatureImport() async {
    await assertDiagnostics(
      '''
import 'package:test/src/features/profile/profile.dart';

Profile? value;
''',
      [
        lint(7, 48, messageContainsAll: ['profile']),
      ],
    );
  }

  Future<void> allowsConfigFeatureImport() async {
    await assertNoDiagnostics('''
import 'package:test/src/features/profile/profile.dart';

Profile? value;
''');
  }
}

ArchitecturePolicy _policy() {
  const groups = <String, GroupConfig>{
    'features': GroupConfig(name: 'features', modules: ['test']),
  };
  const modules = <String, ModuleConfig>{
    'test': ModuleConfig(name: 'test', path: 'test', allowedGroups: []),
  };
  return ArchitecturePolicy(
    repositoryRoot: '/home',
    config: const ArchitectureConfig(
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
