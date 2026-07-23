import 'package:analyzer_testing/analysis_rule/analysis_rule.dart';
import 'package:project_lints/project_lints.dart';
import 'package:test/test.dart';

void main() {
  group('AvoidForceUnwrapRule', () {
    late _AvoidForceUnwrapRuleTest testHarness;

    setUp(() {
      testHarness = _AvoidForceUnwrapRuleTest()..setUp();
    });
    tearDown(() => testHarness.tearDown());

    test(
      'rejects a postfix null assertion',
      () => testHarness.rejectsNullAssertion(),
    );
    test(
      'allows null-aware and explicit null handling',
      () => testHarness.allowsSafeNullHandling(),
    );
    test(
      'allows other exclamation-mark operators',
      () => testHarness.allowsOtherExclamationOperators(),
    );
    test(
      'allows increment and decrement operators',
      () => testHarness.allowsOtherPostfixOperators(),
    );
  });

  test('ignores .g. generated files', () async {
    final testHarness = _GeneratedGFileRuleTest()..setUp();
    addTearDown(testHarness.tearDown);
    await testHarness.ignoresGeneratedFile();
  });

  test('ignores .freezed. generated files', () async {
    final testHarness = _GeneratedFreezedFileRuleTest()..setUp();
    addTearDown(testHarness.tearDown);
    await testHarness.ignoresGeneratedFile();
  });
}

class _AvoidForceUnwrapRuleTest extends AnalysisRuleTest {
  @override
  void setUp() {
    rule = AvoidForceUnwrapRule();
    super.setUp();
  }

  Future<void> rejectsNullAssertion() async {
    await assertDiagnostics(
      'String unwrap(String? value) => value!;',
      [lint(37, 1)],
    );
  }

  Future<void> allowsSafeNullHandling() async {
    await assertNoDiagnostics('''
String fallback(String? value) => value ?? '';

int? preserveNull(String? value) => value?.length;

String explicitCheck(String? value) {
  if (value == null) return '';
  return value;
}
''');
  }

  Future<void> allowsOtherExclamationOperators() async {
    await assertNoDiagnostics('''
bool isMissing(String? value) => value != null && !value.isEmpty;
''');
  }

  Future<void> allowsOtherPostfixOperators() async {
    await assertNoDiagnostics('''
void update() {
  var value = 0;
  value++;
  value--;
}
''');
  }
}

class _GeneratedGFileRuleTest extends AnalysisRuleTest {
  @override
  String get testFileName => 'user_model.g.dart';

  @override
  void setUp() {
    rule = AvoidForceUnwrapRule();
    super.setUp();
  }

  Future<void> ignoresGeneratedFile() async {
    await assertNoDiagnostics('String unwrap(String? value) => value!;');
  }
}

class _GeneratedFreezedFileRuleTest extends AnalysisRuleTest {
  @override
  String get testFileName => 'user_model.freezed.dart';

  @override
  void setUp() {
    rule = AvoidForceUnwrapRule();
    super.setUp();
  }

  Future<void> ignoresGeneratedFile() async {
    await assertNoDiagnostics('String unwrap(String? value) => value!;');
  }
}
