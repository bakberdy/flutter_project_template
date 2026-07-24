import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared/shared.dart';

void main() {
  testWidgets('shows Talker button in a development release build', (
    tester,
  ) async {
    final showTalkerDock = ValueNotifier<bool>(true);
    addTearDown(showTalkerDock.dispose);

    await tester.pumpWidget(
      MaterialApp(
        home: DebugOverlay(
          showTalkerDock: showTalkerDock,
          onOpenTalker: () {},
          bannerColor: Colors.blue,
          environment: ' Development ',
          debugMode: false,
          child: const SizedBox(),
        ),
      ),
    );

    expect(find.byIcon(Icons.bug_report_outlined), findsOneWidget);
  });

  testWidgets('hides Talker button in a production release build', (
    tester,
  ) async {
    final showTalkerDock = ValueNotifier<bool>(true);
    addTearDown(showTalkerDock.dispose);

    await tester.pumpWidget(
      MaterialApp(
        home: DebugOverlay(
          showTalkerDock: showTalkerDock,
          onOpenTalker: () {},
          bannerColor: Colors.blue,
          environment: 'production',
          debugMode: false,
          child: const SizedBox(),
        ),
      ),
    );

    expect(find.byIcon(Icons.bug_report_outlined), findsNothing);
  });
}
