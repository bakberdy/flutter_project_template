import 'package:admin_profile/gen/assets.gen.dart';
import 'package:admin_profile/gen/l10n/admin_profile_localizations.dart';
import 'package:admin_profile/src/common/presentation/extensions/admin_profile_context_x.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('exposes generated localization and assets', (tester) async {
    await tester.pumpWidget(
      Localizations(
        locale: const Locale('en'),
        delegates: const [
          DefaultWidgetsLocalizations.delegate,
          AdminProfileLocalizations.delegate,
        ],
        child: Builder(
          builder: (context) {
            expect(context.l10n, isA<AdminProfileLocalizations>());
            expect(context.assets, same(Assets.adminProfile));
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  });
}
