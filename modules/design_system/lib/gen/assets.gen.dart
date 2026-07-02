// dart format width=120

/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use,directives_ordering,implicit_dynamic_list_literal,unnecessary_import

import 'package:flutter/widgets.dart';

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// Directory path: assets/icons/country_flags
  $AssetsIconsCountryFlagsGen get countryFlags => const $AssetsIconsCountryFlagsGen();

  /// Directory path: assets/icons/general
  $AssetsIconsGeneralGen get general => const $AssetsIconsGeneralGen();
}

class $AssetsLauncherIconGen {
  const $AssetsLauncherIconGen();

  /// File path: assets/launcher_icon/development.png
  AssetGenImage get development => const AssetGenImage('assets/launcher_icon/development.png');

  /// File path: assets/launcher_icon/production.png
  AssetGenImage get production => const AssetGenImage('assets/launcher_icon/production.png');

  /// File path: assets/launcher_icon/staging.png
  AssetGenImage get staging => const AssetGenImage('assets/launcher_icon/staging.png');

  /// List of all assets
  List<AssetGenImage> get values => [development, production, staging];
}

class $AssetsIconsCountryFlagsGen {
  const $AssetsIconsCountryFlagsGen();

  /// File path: assets/icons/country_flags/kazakhstan.png
  AssetGenImage get kazakhstan => const AssetGenImage('assets/icons/country_flags/kazakhstan.png');

  /// File path: assets/icons/country_flags/russia.png
  AssetGenImage get russia => const AssetGenImage('assets/icons/country_flags/russia.png');

  /// File path: assets/icons/country_flags/united_kingdom.png
  AssetGenImage get unitedKingdom => const AssetGenImage('assets/icons/country_flags/united_kingdom.png');

  /// File path: assets/icons/country_flags/united_states.png
  AssetGenImage get unitedStates => const AssetGenImage('assets/icons/country_flags/united_states.png');

  /// List of all assets
  List<AssetGenImage> get values => [kazakhstan, russia, unitedKingdom, unitedStates];
}

class $AssetsIconsGeneralGen {
  const $AssetsIconsGeneralGen();

  /// File path: assets/icons/general/filter.png
  AssetGenImage get filter => const AssetGenImage('assets/icons/general/filter.png');

  /// File path: assets/icons/general/location_point.png
  AssetGenImage get locationPoint => const AssetGenImage('assets/icons/general/location_point.png');

  /// File path: assets/icons/general/route.png
  AssetGenImage get route => const AssetGenImage('assets/icons/general/route.png');

  /// File path: assets/icons/general/sort.png
  AssetGenImage get sort => const AssetGenImage('assets/icons/general/sort.png');

  /// List of all assets
  List<AssetGenImage> get values => [filter, locationPoint, route, sort];
}

class Assets {
  const Assets._();

  static const String package = 'design_system';

  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsLauncherIconGen launcherIcon = $AssetsLauncherIconGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName, {this.size, this.flavors = const {}, this.animation});

  final String _assetName;

  static const String package = 'design_system';

  final Size? size;
  final Set<String> flavors;
  final AssetGenImageAnimation? animation;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    @Deprecated('Do not specify package for a generated library asset') String? package = package,
    FilterQuality filterQuality = FilterQuality.medium,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    @Deprecated('Do not specify package for a generated library asset') String? package = package,
  }) {
    return AssetImage(_assetName, bundle: bundle, package: package);
  }

  String get path => _assetName;

  String get keyName => 'packages/design_system/$_assetName';
}

class AssetGenImageAnimation {
  const AssetGenImageAnimation({required this.isAnimation, required this.duration, required this.frames});

  final bool isAnimation;
  final Duration duration;
  final int frames;
}
