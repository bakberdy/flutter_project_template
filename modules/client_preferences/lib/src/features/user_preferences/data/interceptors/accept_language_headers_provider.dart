import 'package:client_preferences/src/common/config/client_preferences_constants.dart';
import 'package:core/core.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
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
      key: ClientPreferencesConstants.localeStorageKey,
    );
    final normalized = stored?.trim().toLowerCase();
    final isSupported = ClientPreferencesConstants.supportedLocales.any(
      (locale) => locale.languageCode == normalized,
    );
    return isSupported
        ? normalized!
        : ClientPreferencesConstants.defaultLocale.languageCode;
  }
}
