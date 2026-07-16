import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget buildSubject({String? label}) => MaterialApp(
    theme: DesignTheme.light(),
    home: Scaffold(body: BaseInputField(label: label)),
  );

  testWidgets('renders the optional label above the form field', (
    tester,
  ) async {
    await tester.pumpWidget(buildSubject(label: 'Full name'));

    final label = tester.widget<Text>(find.text('Full name'));
    final context = tester.element(find.byType(BaseInputField));

    expect(label.style, Theme.of(context).textTheme.labelLarge);
    expect(find.byType(TextFormField), findsOneWidget);
  });

  testWidgets('omits the label when it is not provided', (tester) async {
    await tester.pumpWidget(buildSubject());

    expect(find.byType(Text), findsNothing);
    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is SizedBox && widget.height == DesignSpacingTokens.xs,
      ),
      findsNothing,
    );
    expect(find.byType(TextFormField), findsOneWidget);
  });
}
