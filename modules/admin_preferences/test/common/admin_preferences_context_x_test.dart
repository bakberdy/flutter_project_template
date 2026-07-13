import 'package:admin_preferences/gen/assets.gen.dart';
import 'package:admin_preferences/gen/l10n/admin_preferences_localizations.dart';
import 'package:admin_preferences/src/common/admin_preferences_context_x.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('exposes generated localization and assets', (tester) async {
    await tester.pumpWidget(
      Localizations(
        locale: const Locale('en'),
        delegates: const [
          DefaultWidgetsLocalizations.delegate,
          AdminPreferencesLocalizations.delegate,
        ],
        child: Builder(
          builder: (context) {
            expect(context.l10n, isA<AdminPreferencesLocalizations>());
            expect(context.assets, same(Assets.adminPreferences));
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  });
}
