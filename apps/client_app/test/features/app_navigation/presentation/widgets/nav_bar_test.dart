import 'package:client_app/src/common/presentation/widgets/nav_bar.dart';
import 'package:client_app/src/common/presentation/widgets/nav_bar_item.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('changes the selected item on tap', (tester) async {
    int? selectedIndex;

    await tester.pumpWidget(
      MaterialApp(
        theme: DesignTheme.light(),
        home: Scaffold(
          bottomNavigationBar: NavBar(
            initialPage: 0,
            onPageChanged: (index) => selectedIndex = index,
            items: const [
              NavBarItem(icon: Icon(Icons.home, size: 20), label: 'Home'),
              NavBarItem(icon: Icon(Icons.person, size: 20), label: 'Profile'),
            ],
          ),
        ),
      ),
    );

    await tester.tap(find.text('Profile'));
    await tester.pumpAndSettle();

    expect(selectedIndex, 1);
    final profileLabel = tester.widget<Text>(find.text('Profile'));
    expect(profileLabel.style?.color, DesignTheme.light().colorScheme.primary);
  });

  testWidgets('reports a tap on the already selected item', (tester) async {
    var tapCount = 0;

    await tester.pumpWidget(
      MaterialApp(
        theme: DesignTheme.light(),
        home: Scaffold(
          bottomNavigationBar: NavBar(
            initialPage: 0,
            onPageChanged: (_) => tapCount++,
            items: const [
              NavBarItem(icon: Icon(Icons.home, size: 20), label: 'Home'),
              NavBarItem(icon: Icon(Icons.person, size: 20), label: 'Profile'),
            ],
          ),
        ),
      ),
    );

    await tester.tap(find.text('Home'));
    await tester.pumpAndSettle();

    expect(tapCount, 1);
  });
}
