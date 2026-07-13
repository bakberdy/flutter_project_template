import 'package:client_auth/gen/assets.gen.dart';
import 'package:client_auth/gen/l10n/client_auth_localizations.dart';
import 'package:client_auth/src/common/client_auth_context_x.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('exposes generated localization and assets', (tester) async {
    await tester.pumpWidget(
      Localizations(
        locale: const Locale('en'),
        delegates: const [
          DefaultWidgetsLocalizations.delegate,
          ClientAuthLocalizations.delegate,
        ],
        child: Builder(
          builder: (context) {
            expect(context.l10n, isA<ClientAuthLocalizations>());
            expect(context.assets, same(Assets.clientAuth));
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  });
}
