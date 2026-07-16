import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('exposes design tokens through context', (tester) async {
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

    expect(subjectContext.designSpacing.md, DesignSpacing.md);
    expect(subjectContext.designRadii.lg, DesignRadii.lg);
    expect(
      subjectContext.designComponentSizes.controlLg,
      DesignComponentSizes.controlLg,
    );
    expect(subjectContext.designElevation.md, DesignElevation.md);
    expect(
      subjectContext.designMotion.durations.standard,
      DesignMotionDurations.standard,
    );
    expect(
      subjectContext.designMotion.curves.emphasized,
      DesignMotionCurves.emphasized,
    );
    expect(
      subjectContext.designShadows.md,
      DesignShadows.md(subjectContext.designColors.shadow),
    );
  });
}
