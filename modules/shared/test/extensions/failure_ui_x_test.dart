import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared/shared.dart';

void main() {
  group('FailureUiX', () {
    testWidgets('preserves backend-owned messages', (tester) async {
      const failure = Failure(
        message: 'Invalid credentials',
        source: 'test',
        reason: FailureReason.backend,
        details: FailureDetails(statusCode: 401),
      );

      expect(
        await _messageFor(tester, failure, const Locale('ru')),
        'Invalid credentials',
      );
    });

    testWidgets('maps connection failures using the active locale', (
      tester,
    ) async {
      const failure = Failure(
        source: 'test',
        reason: FailureReason.noConnection,
        details: FailureDetails(statusCode: 0),
      );

      expect(
        await _messageFor(tester, failure, const Locale('ru')),
        'Нет подключения к интернету',
      );
    });

    testWidgets('maps service failures using the active locale', (
      tester,
    ) async {
      const failure = Failure(
        source: 'test',
        reason: FailureReason.serviceUnavailable,
        details: FailureDetails(statusCode: 503),
      );

      expect(
        await _messageFor(tester, failure, const Locale('kk')),
        'Қызмет уақытша қолжетімсіз. Кейінірек қайталап көріңіз.',
      );
    });

    testWidgets('maps unknown failures to the localized fallback', (
      tester,
    ) async {
      const failure = Failure(
        source: 'test',
        details: FailureDetails(statusCode: 500),
      );

      expect(
        await _messageFor(tester, failure, const Locale('en')),
        'Something went wrong. Try again.',
      );
    });
  });
}

Future<String> _messageFor(
  WidgetTester tester,
  Failure failure,
  Locale locale,
) async {
  late String message;
  await tester.pumpWidget(
    Localizations(
      locale: locale,
      delegates: const [
        DefaultWidgetsLocalizations.delegate,
        SharedLocalizations.delegate,
      ],
      child: Builder(
        builder: (context) {
          message = failure.messageTextOrDefault(context);
          return const SizedBox.shrink();
        },
      ),
    ),
  );
  await tester.pumpAndSettle();
  return message;
}
