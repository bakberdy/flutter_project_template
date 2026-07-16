import 'package:flutter/material.dart';

abstract final class DesignTokens {
  static const spacing = DesignSpacingTokens();
  static const radius = DesignRadiusTokens();
  static const size = DesignSizeTokens();
  static const elevation = DesignElevationTokens();
  static const duration = DesignDurationTokens();
  static const curve = DesignCurveTokens();
  static const shadow = DesignShadowTokens();
}

final class DesignSpacingTokens {
  const DesignSpacingTokens();

  final double xxs = 4;
  final double xs = 8;
  final double sm = 12;
  final double md = 16;
  final double lg = 24;
  final double xl = 32;
}

final class DesignRadiusTokens {
  const DesignRadiusTokens();

  final double xs = 4;
  final double sm = 8;
  final double md = 12;
  final double lg = 16;
  final double xl = 20;
  final double xxl = 24;
  final double sheet = 28;
}

final class DesignSizeTokens {
  const DesignSizeTokens();

  final double iconXs = 16;
  final double iconSm = 20;
  final double iconMd = 24;
  final double iconLg = 32;
  final double iconXl = 48;

  final double controlSm = 32;
  final double controlMd = 40;
  final double controlLg = 48;
  final double minimumTouchTarget = 48;

  final double appBar = 64;
  final double bottomNavigation = 64;
  final double navigationRail = 80;
}

final class DesignElevationTokens {
  const DesignElevationTokens();

  final double none = 0;
  final double xs = 1;
  final double sm = 2;
  final double md = 4;
  final double lg = 8;
  final double xl = 16;
}

final class DesignDurationTokens {
  const DesignDurationTokens();

  final Duration instant = const Duration(milliseconds: 100);
  final Duration fast = const Duration(milliseconds: 200);
  final Duration standard = const Duration(milliseconds: 300);
  final Duration slow = const Duration(milliseconds: 500);
}

final class DesignCurveTokens {
  const DesignCurveTokens();

  final Curve standard = Curves.easeInOutCubic;
  final Curve emphasized = Curves.easeOutCubic;
  final Curve enter = Curves.easeOut;
  final Curve exit = Curves.easeIn;
}

final class DesignShadowTokens {
  const DesignShadowTokens();

  List<BoxShadow> xs(Color color) => [
    BoxShadow(
      color: color.withValues(alpha: 0.08),
      blurRadius: 2,
      offset: const Offset(0, 1),
    ),
  ];

  List<BoxShadow> sm(Color color) => [
    BoxShadow(
      color: color.withValues(alpha: 0.10),
      blurRadius: 6,
      offset: const Offset(0, 2),
    ),
  ];

  List<BoxShadow> md(Color color) => [
    BoxShadow(
      color: color.withValues(alpha: 0.12),
      blurRadius: 12,
      offset: const Offset(0, 4),
    ),
  ];

  List<BoxShadow> lg(Color color) => [
    BoxShadow(
      color: color.withValues(alpha: 0.14),
      blurRadius: 24,
      offset: const Offset(0, 8),
    ),
  ];
}
