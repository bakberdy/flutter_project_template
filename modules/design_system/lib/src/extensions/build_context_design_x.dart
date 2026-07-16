import 'package:design_system/gen/assets.gen.dart' as ds_assets;
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

final class DsContextAssets {
  const DsContextAssets();

  ds_assets.$AssetsIconsGen get images => ds_assets.Assets.icons;
  ds_assets.$AssetsIconsGen get icons => ds_assets.Assets.icons;
  ds_assets.$AssetsLauncherIconGen get launcherIcon =>
      ds_assets.Assets.launcherIcon;
}
