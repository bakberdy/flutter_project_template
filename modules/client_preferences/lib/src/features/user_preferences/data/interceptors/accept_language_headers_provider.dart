import 'package:core/core.dart';
import 'package:client_preferences/src/common/config/local_storage_consts.dart';
import 'package:client_preferences/src/common/config/locale_constants.dart';
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
    final stored = await _localStorage.read(key: LocalStorageConsts.localeKey);
    final normalized = stored?.trim().toLowerCase();
    final isSupported = ClientPreferencesLocaleConstants.supportedLocales.any(
      (locale) => locale.languageCode == normalized,
    );
    return isSupported
        ? normalized!
        : ClientPreferencesLocaleConstants.defaultLocale.languageCode;
  }
}
