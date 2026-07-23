import 'package:client_profile/gen/assets.gen.dart';
import 'package:client_profile/gen/l10n/client_profile_localizations.dart';
import 'package:client_profile/src/common/presentation/extensions/client_profile_context_x.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('exposes generated localization and assets', (tester) async {
    await tester.pumpWidget(
      Localizations(
        locale: const Locale('en'),
        delegates: const [
          DefaultWidgetsLocalizations.delegate,
          ClientProfileLocalizations.delegate,
        ],
        child: Builder(
          builder: (context) {
            expect(context.l10n, isA<ClientProfileLocalizations>());
            expect(context.assets, same(Assets.clientProfile));
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  });
}
