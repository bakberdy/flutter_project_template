import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('keeps temporary context aliases for downstream migration', (
    tester,
  ) async {
    late BuildContext subjectContext;

    await tester.pumpWidget(
      MaterialApp(
        theme: DesignTheme.light(),
        home: Builder(
          builder: (context) {
            subjectContext = context;
            return const SizedBox.shrink();
          },
        ),
      ),
    );

    expect(subjectContext.designSpacing.md, DesignTokens.spacing.md);
    expect(subjectContext.designRadii.lg, DesignTokens.radius.lg);
  });
}
