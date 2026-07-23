import 'package:analyzer_testing/analysis_rule/analysis_rule.dart';
import 'package:project_lints/project_lints.dart';
import 'package:test/test.dart';

void main() {
  group('ClassNameMatchesFileNameRule', () {
    late _ClassNameRuleTest testHarness;

    setUp(() {
      testHarness = _ClassNameRuleTest()..setUp();
    });
    tearDown(() => testHarness.tearDown());

    test(
      'allows the matching public class',
      () => testHarness.allowsMatchingClass(),
    );
    test(
      'allows other public classes when one class matches',
      () => testHarness.allowsOtherClassesWithMatchingClass(),
    );
    test(
      'rejects a mismatched public class',
      () => testHarness.rejectsMismatchedClass(),
    );
    test(
      'ignores a file without a public class',
      () => testHarness.ignoresPrivateClass(),
    );
    test(
      'ignores a library that declares a part',
      () => testHarness.ignoresPartDirective(),
    );
    test(
      'ignores a part file',
      () => testHarness.ignoresPartOfDirective(),
    );
  });

  test('ignores analytics events files', () async {
    final testHarness = _AnalyticsEventsRuleTest()..setUp();
    addTearDown(testHarness.tearDown);
    await testHarness.ignoresAnalyticsEventsFile();
  });
}

class _ClassNameRuleTest extends AnalysisRuleTest {
  @override
  String get testFileName => 'my_service.dart';

  @override
  void setUp() {
    rule = ClassNameMatchesFileNameRule();
    super.setUp();
  }

  Future<void> allowsMatchingClass() async {
    await assertNoDiagnostics('class MyService {}');
  }

  Future<void> allowsOtherClassesWithMatchingClass() async {
    await assertNoDiagnostics('''
class MyService {}
class OtherService {}
''');
  }

  Future<void> rejectsMismatchedClass() async {
    await assertDiagnostics(
      'class OtherService {}',
      [
        lint(
          6,
          12,
          messageContainsAll: ['OtherService', 'MyService'],
        ),
      ],
    );
  }

  Future<void> ignoresPrivateClass() async {
    await assertNoDiagnostics('class _MyService {}');
  }

  Future<void> ignoresPartDirective() async {
    newFile(
      '$testPackageLibPath/my_service_part.dart',
      'part of "my_service.dart";',
    );
    await assertNoDiagnostics('''
part 'my_service_part.dart';
class OtherService {}
''');
  }

  Future<void> ignoresPartOfDirective() async {
    await assertNoDiagnostics('''
part of 'my_library.dart';
class OtherService {}
''');
  }
}

class _AnalyticsEventsRuleTest extends AnalysisRuleTest {
  @override
  String get testFileName => 'domain/analytics/user_profile_events.dart';

  @override
  void setUp() {
    rule = ClassNameMatchesFileNameRule();
    super.setUp();
  }

  Future<void> ignoresAnalyticsEventsFile() async {
    await assertNoDiagnostics('class GetCurrentUserEvent {}');
  }
}
