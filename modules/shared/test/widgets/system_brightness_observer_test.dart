import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared/shared.dart';

void main() {
  testWidgets('reports initial and changed platform brightness', (
    tester,
  ) async {
    final initialBrightness = <Brightness>[];
    final changedBrightness = <Brightness>[];

    tester.binding.platformDispatcher.platformBrightnessTestValue =
        Brightness.dark;
    addTearDown(
      tester.binding.platformDispatcher.clearPlatformBrightnessTestValue,
    );

    await tester.pumpWidget(
      SystemBrightnessObserver(
        onInitialBrightness: initialBrightness.add,
        onBrightnessChanged: changedBrightness.add,
        child: const SizedBox(),
      ),
    );

    expect(initialBrightness, [Brightness.dark]);

    tester.binding.platformDispatcher.platformBrightnessTestValue =
        Brightness.light;
    await tester.pump();

    expect(changedBrightness, [Brightness.light]);
  });

  testWidgets('reports current brightness when the app resumes', (
    tester,
  ) async {
    final changedBrightness = <Brightness>[];

    tester.binding.platformDispatcher.platformBrightnessTestValue =
        Brightness.dark;
    addTearDown(
      tester.binding.platformDispatcher.clearPlatformBrightnessTestValue,
    );

    await tester.pumpWidget(
      SystemBrightnessObserver(
        onInitialBrightness: (_) {},
        onBrightnessChanged: changedBrightness.add,
        child: const SizedBox(),
      ),
    );

    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.paused);
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
    await tester.pump();

    expect(changedBrightness, [Brightness.dark]);
  });
}
