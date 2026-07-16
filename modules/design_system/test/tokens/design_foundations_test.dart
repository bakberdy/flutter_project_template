import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('centralizes values in static token classes', () {
    expect(DesignSpacingTokens.md, 16);
    expect(DesignRadiusTokens.lg, 16);
    expect(DesignSizeTokens.controlLg, 48);
    expect(DesignElevationTokens.md, 4);
    expect(DesignDurationTokens.standard, const Duration(milliseconds: 300));
    expect(DesignCurveTokens.emphasized, Curves.easeOutCubic);
  });

  test('value tokens can be used by const widgets', () {
    const widget = SizedBox(
      width: DesignSizeTokens.controlLg,
      height: DesignSpacingTokens.md,
    );

    expect(widget.width, 48);
    expect(widget.height, 16);
  });

  test('component sizes preserve minimum accessible touch targets', () {
    expect(DesignSizeTokens.minimumTouchTarget, greaterThanOrEqualTo(48));
    expect(DesignSizeTokens.controlLg, DesignSizeTokens.minimumTouchTarget);
  });

  test('motion tokens are ordered from fastest to slowest', () {
    expect(DesignDurationTokens.instant, lessThan(DesignDurationTokens.fast));
    expect(DesignDurationTokens.fast, lessThan(DesignDurationTokens.standard));
    expect(DesignDurationTokens.standard, lessThan(DesignDurationTokens.slow));
    expect(DesignCurveTokens.standard, Curves.easeInOutCubic);
  });

  test('shadow tokens grow in visual depth', () {
    const color = Colors.black;
    expect(
      DesignShadowTokens.xs(color).single.blurRadius,
      lessThan(DesignShadowTokens.sm(color).single.blurRadius),
    );
    expect(
      DesignShadowTokens.sm(color).single.blurRadius,
      lessThan(DesignShadowTokens.md(color).single.blurRadius),
    );
    expect(
      DesignShadowTokens.md(color).single.blurRadius,
      lessThan(DesignShadowTokens.lg(color).single.blurRadius),
    );
  });
}
