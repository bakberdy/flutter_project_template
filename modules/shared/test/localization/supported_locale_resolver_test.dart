import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:shared/shared.dart';

void main() {
  const supportedLocales = [Locale('en'), Locale('ru'), Locale('kk')];

  test('returns the supported locale matching the language code', () {
    expect(
      resolveSupportedLocale(
        const Locale('ru', 'RU'),
        supportedLocales,
        fallback: const Locale('en'),
      ),
      const Locale('ru'),
    );
  });

  test('returns fallback when device locale is unsupported', () {
    expect(
      resolveSupportedLocale(
        const Locale('de'),
        supportedLocales,
        fallback: const Locale('en'),
      ),
      const Locale('en'),
    );
  });
}
