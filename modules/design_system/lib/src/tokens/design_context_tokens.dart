import 'package:design_system/src/tokens/design_component_sizes.dart';
import 'package:design_system/src/tokens/design_elevation.dart';
import 'package:design_system/src/tokens/design_motion.dart';
import 'package:design_system/src/tokens/design_radii.dart';
import 'package:design_system/src/tokens/design_shadows.dart';
import 'package:design_system/src/tokens/design_spacing.dart';
import 'package:flutter/material.dart';

final class DsContextSpacing {
  const DsContextSpacing();

  double get xxs => DesignSpacing.xxs;
  double get xs => DesignSpacing.xs;
  double get sm => DesignSpacing.sm;
  double get md => DesignSpacing.md;
  double get lg => DesignSpacing.lg;
  double get xl => DesignSpacing.xl;
}

final class DsContextRadii {
  const DsContextRadii();

  double get xs => DesignRadii.xs;
  double get sm => DesignRadii.sm;
  double get md => DesignRadii.md;
  double get lg => DesignRadii.lg;
  double get xl => DesignRadii.xl;
  double get xxl => DesignRadii.xxl;
  double get sheet => DesignRadii.sheet;
}

final class DsContextComponentSizes {
  const DsContextComponentSizes();

  double get iconXs => DesignComponentSizes.iconXs;
  double get iconSm => DesignComponentSizes.iconSm;
  double get iconMd => DesignComponentSizes.iconMd;
  double get iconLg => DesignComponentSizes.iconLg;
  double get iconXl => DesignComponentSizes.iconXl;

  double get controlSm => DesignComponentSizes.controlSm;
  double get controlMd => DesignComponentSizes.controlMd;
  double get controlLg => DesignComponentSizes.controlLg;
  double get minimumTouchTarget => DesignComponentSizes.minimumTouchTarget;

  double get appBar => DesignComponentSizes.appBar;
  double get bottomNavigation => DesignComponentSizes.bottomNavigation;
  double get navigationRail => DesignComponentSizes.navigationRail;
}

final class DsContextElevation {
  const DsContextElevation();

  double get none => DesignElevation.none;
  double get xs => DesignElevation.xs;
  double get sm => DesignElevation.sm;
  double get md => DesignElevation.md;
  double get lg => DesignElevation.lg;
  double get xl => DesignElevation.xl;
}

final class DsContextMotion {
  const DsContextMotion();

  DsContextMotionDurations get durations => const DsContextMotionDurations();
  DsContextMotionCurves get curves => const DsContextMotionCurves();
}

final class DsContextMotionDurations {
  const DsContextMotionDurations();

  Duration get instant => DesignMotionDurations.instant;
  Duration get fast => DesignMotionDurations.fast;
  Duration get standard => DesignMotionDurations.standard;
  Duration get slow => DesignMotionDurations.slow;
}

final class DsContextMotionCurves {
  const DsContextMotionCurves();

  Curve get standard => DesignMotionCurves.standard;
  Curve get emphasized => DesignMotionCurves.emphasized;
  Curve get enter => DesignMotionCurves.enter;
  Curve get exit => DesignMotionCurves.exit;
}

final class DsContextShadows {
  const DsContextShadows(this.color);

  final Color color;

  List<BoxShadow> get xs => DesignShadows.xs(color);
  List<BoxShadow> get sm => DesignShadows.sm(color);
  List<BoxShadow> get md => DesignShadows.md(color);
  List<BoxShadow> get lg => DesignShadows.lg(color);
}
