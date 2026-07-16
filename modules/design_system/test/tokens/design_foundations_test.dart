import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('component sizes preserve minimum accessible touch targets', () {
    expect(DesignComponentSizes.minimumTouchTarget, greaterThanOrEqualTo(48));
    expect(
      DesignComponentSizes.controlLg,
      DesignComponentSizes.minimumTouchTarget,
    );
  });

  test('motion tokens are ordered from fastest to slowest', () {
    expect(DesignMotionDurations.instant, lessThan(DesignMotionDurations.fast));
    expect(
      DesignMotionDurations.fast,
      lessThan(DesignMotionDurations.standard),
    );
    expect(
      DesignMotionDurations.standard,
      lessThan(DesignMotionDurations.slow),
    );
    expect(DesignMotionCurves.standard, Curves.easeInOutCubic);
  });

  test('shadow tokens grow in visual depth', () {
    const color = Colors.black;
    expect(
      DesignShadows.xs(color).single.blurRadius,
      lessThan(DesignShadows.sm(color).single.blurRadius),
    );
    expect(
      DesignShadows.sm(color).single.blurRadius,
      lessThan(DesignShadows.md(color).single.blurRadius),
    );
    expect(
      DesignShadows.md(color).single.blurRadius,
      lessThan(DesignShadows.lg(color).single.blurRadius),
    );
  });
}
