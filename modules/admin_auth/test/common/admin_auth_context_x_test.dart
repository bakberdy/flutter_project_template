import 'package:admin_auth/gen/assets.gen.dart';
import 'package:admin_auth/gen/l10n/admin_auth_localizations.dart';
import 'package:admin_auth/src/common/admin_auth_context_x.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('exposes generated localization and assets', (tester) async {
    await tester.pumpWidget(
      Localizations(
        locale: const Locale('en'),
        delegates: const [
          DefaultWidgetsLocalizations.delegate,
          AdminAuthLocalizations.delegate,
        ],
        child: Builder(
          builder: (context) {
            expect(context.l10n, isA<AdminAuthLocalizations>());
            expect(context.assets, same(Assets.adminAuth));
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  });
}
