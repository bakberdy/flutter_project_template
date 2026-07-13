import 'package:admin_users/gen/l10n/admin_users_localizations.dart';
import 'package:admin_users/src/features/users/presentation/widgets/users_pagination.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('lays out pagination buttons inside an unconstrained row', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: DesignTheme.light(),
        localizationsDelegates: AdminUsersLocalizations.localizationsDelegates,
        supportedLocales: AdminUsersLocalizations.supportedLocales,
        home: Scaffold(
          body: UsersPagination(
            pagination: const PaginationMeta(
              page: 2,
              limit: 20,
              totalItems: 60,
              totalPages: 3,
              hasNext: true,
              hasPrevious: true,
            ),
            onPageChanged: (_) {},
          ),
        ),
      ),
    );

    expect(tester.takeException(), isNull);
    expect(find.text('Previous'), findsOneWidget);
    expect(find.text('Next'), findsOneWidget);
  });
}
