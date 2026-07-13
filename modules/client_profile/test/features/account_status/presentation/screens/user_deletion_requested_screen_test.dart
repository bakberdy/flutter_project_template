import 'package:client_profile/gen/l10n/client_profile_localizations.dart';
import 'package:client_profile/src/features/account_status/presentation/screens/user_deletion_requested_screen.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('shows pending copy for a deletion request', (tester) async {
    await tester.pumpWidget(_app(isDeleted: false));

    expect(find.text('Запрошено удаление'), findsOneWidget);
    expect(
      find.textContaining('Запрос на удаление аккаунта обрабатывается'),
      findsOneWidget,
    );
    expect(find.text('Ваш аккаунт удалён'), findsNothing);
  });

  testWidgets('shows completed copy for a deleted account', (tester) async {
    await tester.pumpWidget(_app(isDeleted: true));

    expect(find.text('Ваш аккаунт удалён'), findsOneWidget);
    expect(
      find.textContaining('Этот аккаунт был окончательно удалён'),
      findsOneWidget,
    );
    expect(find.text('Запрошено удаление'), findsNothing);
  });
}

Widget _app({required bool isDeleted}) => MaterialApp(
  locale: const Locale('ru'),
  theme: DesignTheme.light(),
  localizationsDelegates: const [ClientProfileLocalizations.delegate],
  supportedLocales: ClientProfileLocalizations.supportedLocales,
  home: UserDeletionRequestedScreen(isDeleted: isDeleted),
);
