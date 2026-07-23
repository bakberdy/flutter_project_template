import 'package:admin_preferences/src/common/config/constants/admin_preferences_constants.dart';
import 'package:core/core.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ApiRequestHeadersProvider)
class AcceptLanguageHeadersProvider implements ApiRequestHeadersProvider {
  AcceptLanguageHeadersProvider(this._localStorage);

  final LocalStorage _localStorage;

  static const _headerName = 'Accept-Language';

  @override
  Future<Map<String, dynamic>> headers() async => {
    _headerName: await _languageCode(),
  };

  Future<String> _languageCode() async {
    final stored = await _localStorage.read(
      key: AdminPreferencesConstants.localeStorageKey,
    );
    final normalized = stored?.trim().toLowerCase();
    if (normalized != null &&
        AdminPreferencesConstants.supportedLocales.any(
          (locale) => locale.languageCode == normalized,
        )) {
      return normalized;
    }
    return AdminPreferencesConstants.defaultLocale.languageCode;
  }
}
