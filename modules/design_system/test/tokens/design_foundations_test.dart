import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('centralizes value tokens under DesignTokens', () {
    expect(DesignTokens.spacing.md, 16);
    expect(DesignTokens.radius.lg, 16);
    expect(DesignTokens.size.controlLg, 48);
    expect(DesignTokens.elevation.md, 4);
    expect(DesignTokens.duration.standard, const Duration(milliseconds: 300));
    expect(DesignTokens.curve.emphasized, Curves.easeOutCubic);
  });

  test('component sizes preserve minimum accessible touch targets', () {
    expect(DesignTokens.size.minimumTouchTarget, greaterThanOrEqualTo(48));
    expect(DesignTokens.size.controlLg, DesignTokens.size.minimumTouchTarget);
  });

  test('motion tokens are ordered from fastest to slowest', () {
    expect(DesignTokens.duration.instant, lessThan(DesignTokens.duration.fast));
    expect(
      DesignTokens.duration.fast,
      lessThan(DesignTokens.duration.standard),
    );
    expect(
      DesignTokens.duration.standard,
      lessThan(DesignTokens.duration.slow),
    );
    expect(DesignTokens.curve.standard, Curves.easeInOutCubic);
  });

  test('shadow tokens grow in visual depth', () {
    const color = Colors.black;
    expect(
      DesignTokens.shadow.xs(color).single.blurRadius,
      lessThan(DesignTokens.shadow.sm(color).single.blurRadius),
    );
    expect(
      DesignTokens.shadow.sm(color).single.blurRadius,
      lessThan(DesignTokens.shadow.md(color).single.blurRadius),
    );
    expect(
      DesignTokens.shadow.md(color).single.blurRadius,
      lessThan(DesignTokens.shadow.lg(color).single.blurRadius),
    );
  });
}
