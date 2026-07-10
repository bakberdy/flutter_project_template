import 'package:client_auth/gen/l10n/client_auth_localizations.dart';
import 'package:design_system/gen/assets.gen.dart' as ds_assets;
import 'package:flutter/material.dart';

extension ClientAuthContextX on BuildContext {
  ClientAuthLocalizations get l10n => ClientAuthLocalizations.of(this);
  Locale get locale => Localizations.localeOf(this);
  ClientAuthContextAssets get assets => const ClientAuthContextAssets();
  bool get isRTL {
    final languageCode = locale.languageCode;
    return ['ar', 'he', 'fa', 'ur'].contains(languageCode);
  }

  String get languageCode => locale.languageCode;
}

final class ClientAuthContextAssets {
  const ClientAuthContextAssets();

  ds_assets.$AssetsIconsGen get icons => ds_assets.Assets.icons;
}
