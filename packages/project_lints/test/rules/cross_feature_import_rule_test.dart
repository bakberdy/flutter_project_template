import 'package:analyzer_testing/analysis_rule/analysis_rule.dart';
import 'package:project_lints/project_lints.dart';
import 'package:test/test.dart';

void main() {
  late _CrossFeatureImportRuleTest testHarness;

  setUp(() {
    testHarness = _CrossFeatureImportRuleTest()..setUp();
  });
  tearDown(() => testHarness.tearDown());

  test(
    'allows an import from the same feature',
    () => testHarness.allowsImportFromSameFeature(),
  );
  test(
    'rejects a package import from another feature',
    () => testHarness.rejectsImportFromAnotherFeature(),
  );
  test(
    'rejects a relative import from another feature',
    () => testHarness.rejectsRelativeImportFromAnotherFeature(),
  );
}

class _CrossFeatureImportRuleTest extends AnalysisRuleTest {
  @override
  String get testFileName => 'src/features/profile/test.dart';

  @override
  void setUp() {
    rule = CrossFeatureImportRule(policyResolver: (_) => _policy());
    super.setUp();
    newFile(
      '$testPackageLibPath/src/features/profile/profile.dart',
      'class Profile {}',
    );
    newFile(
      '$testPackageLibPath/src/features/sessions/session.dart',
      'class Session {}',
    );
  }

  Future<void> allowsImportFromSameFeature() async {
    await assertNoDiagnostics('''
import 'package:test/src/features/profile/profile.dart';

Profile? value;
''');
  }

  Future<void> rejectsImportFromAnotherFeature() async {
    await assertDiagnostics(
      '''
import 'package:test/src/features/sessions/session.dart';

Session? value;
''',
      [
        lint(7, 49, messageContainsAll: ['profile', 'sessions']),
      ],
    );
  }

  Future<void> rejectsRelativeImportFromAnotherFeature() async {
    await assertDiagnostics(
      '''
import '../sessions/session.dart';

Session? value;
''',
      [
        lint(7, 26, messageContainsAll: ['profile', 'sessions']),
      ],
    );
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
