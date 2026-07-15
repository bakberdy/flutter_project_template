import 'dart:ui';

Locale resolveSupportedLocale(
  Locale? deviceLocale,
  Iterable<Locale> supportedLocales, {
  required Locale fallback,
}) {
  for (final locale in supportedLocales) {
    if (locale.languageCode == deviceLocale?.languageCode) {
      return locale;
    }
  }
  return fallback;
}
