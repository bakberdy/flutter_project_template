import 'package:admin_users/gen/assets.gen.dart';
import 'package:admin_users/gen/l10n/admin_users_localizations.dart';
import 'package:admin_users/src/common/admin_users_context_x.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('exposes generated localization and assets', (tester) async {
    await tester.pumpWidget(
      Localizations(
        locale: const Locale('en'),
        delegates: const [
          DefaultWidgetsLocalizations.delegate,
          AdminUsersLocalizations.delegate,
        ],
        child: Builder(
          builder: (context) {
            expect(context.l10n, isA<AdminUsersLocalizations>());
            expect(context.assets, same(Assets.adminUsers));
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  });
}
