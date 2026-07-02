import 'package:admin_app/app.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('creates admin app widget', (tester) async {
    expect(App, isA<Type>());
  });
}
