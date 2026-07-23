import 'package:design_system/src/extensions/ds_context_assets.dart';
import 'package:design_system/src/theme/design_semantic_colors.dart';
import 'package:flutter/material.dart';

extension BuildContextDesignX on BuildContext {
  ThemeData get designTheme => Theme.of(this);
  ColorScheme get designColors => designTheme.colorScheme;
  DesignSemanticColors get designSemanticColors =>
      designTheme.extension<DesignSemanticColors>()!;
  TextTheme get designTextTheme => designTheme.textTheme;
  BottomSheetThemeData get designBottomSheetTheme =>
      designTheme.bottomSheetTheme;
  BottomNavigationBarThemeData get designBottomNavigationBarTheme =>
      designTheme.bottomNavigationBarTheme;
  DsContextAssets get designAssets => const DsContextAssets();
}
