import 'package:design_system/gen/assets.gen.dart' as ds_assets;

final class DsContextAssets {
  const DsContextAssets();

  ds_assets.$AssetsIconsGen get images => ds_assets.Assets.icons;
  ds_assets.$AssetsIconsGen get icons => ds_assets.Assets.icons;
  ds_assets.$AssetsLauncherIconGen get launcherIcon =>
      ds_assets.Assets.launcherIcon;
}
