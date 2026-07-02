import 'package:design_system/gen/assets.gen.dart' as ds_assets;
import 'package:flutter/material.dart';

extension BuildContextDesignX on BuildContext {
  ColorScheme get designColors => Theme.of(this).colorScheme;
  TextTheme get designTextTheme => Theme.of(this).textTheme;
  ColorScheme get colorScheme => designColors;
  TextTheme get textTheme => designTextTheme;
  DsContextAssets get designAssets => const DsContextAssets();
}

final class DsContextAssets {
  const DsContextAssets();

  ds_assets.$AssetsIconsGen get images => ds_assets.Assets.icons;
  ds_assets.$AssetsIconsGen get icons => ds_assets.Assets.icons;
  ds_assets.$AssetsLauncherIconGen get launcherIcon =>
      ds_assets.Assets.launcherIcon;
}
