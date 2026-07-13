import 'package:client_preferences/gen/assets.gen.dart';
import 'package:client_preferences/gen/l10n/client_preferences_localizations.dart';
import 'package:client_preferences/src/common/client_preferences_context_x.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('exposes generated localization and assets', (tester) async {
    await tester.pumpWidget(
      Localizations(
        locale: const Locale('en'),
        delegates: const [
          DefaultWidgetsLocalizations.delegate,
          ClientPreferencesLocalizations.delegate,
        ],
        child: Builder(
          builder: (context) {
            expect(context.l10n, isA<ClientPreferencesLocalizations>());
            expect(context.assets, same(Assets.clientPreferences));
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  });
}
