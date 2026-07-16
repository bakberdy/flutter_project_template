import 'package:flutter/material.dart';

abstract final class DesignTokens {
  static const spacing = DesignSpacingTokens;
  static const radius = DesignRadiusTokens;
  static const size = DesignSizeTokens;
  static const elevation = DesignElevationTokens;
  static const duration = DesignDurationTokens;
  static const curve = DesignCurveTokens;
  static const shadow = DesignShadowTokens;
}

abstract final class DesignSpacingTokens {
  static const double xxs = 4;
  static const double xs = 8;
  static const double sm = 12;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
}

abstract final class DesignRadiusTokens {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 20;
  static const double xxl = 24;
  static const double sheet = 28;
}

abstract final class DesignSizeTokens {
  static const double iconXs = 16;
  static const double iconSm = 20;
  static const double iconMd = 24;
  static const double iconLg = 32;
  static const double iconXl = 48;

  static const double controlSm = 32;
  static const double controlMd = 40;
  static const double controlLg = 48;
  static const double minimumTouchTarget = 48;

  static const double appBar = 64;
  static const double bottomNavigation = 64;
  static const double navigationRail = 80;
}

abstract final class DesignElevationTokens {
  static const double none = 0;
  static const double xs = 1;
  static const double sm = 2;
  static const double md = 4;
  static const double lg = 8;
  static const double xl = 16;
}

abstract final class DesignDurationTokens {
  static const Duration instant = Duration(milliseconds: 100);
  static const Duration fast = Duration(milliseconds: 200);
  static const Duration standard = Duration(milliseconds: 300);
  static const Duration slow = Duration(milliseconds: 500);
}

abstract final class DesignCurveTokens {
  static const Curve standard = Curves.easeInOutCubic;
  static const Curve emphasized = Curves.easeOutCubic;
  static const Curve enter = Curves.easeOut;
  static const Curve exit = Curves.easeIn;
}

abstract final class DesignShadowTokens {
  static List<BoxShadow> xs(Color color) => [
    BoxShadow(
      color: color.withValues(alpha: 0.08),
      blurRadius: 2,
      offset: const Offset(0, 1),
    ),
  ];

  static List<BoxShadow> sm(Color color) => [
    BoxShadow(
      color: color.withValues(alpha: 0.10),
      blurRadius: 6,
      offset: const Offset(0, 2),
    ),
  ];

  static List<BoxShadow> md(Color color) => [
    BoxShadow(
      color: color.withValues(alpha: 0.12),
      blurRadius: 12,
      offset: const Offset(0, 4),
    ),
  ];

  static List<BoxShadow> lg(Color color) => [
    BoxShadow(
      color: color.withValues(alpha: 0.14),
      blurRadius: 24,
      offset: const Offset(0, 8),
    ),
  ];
}
