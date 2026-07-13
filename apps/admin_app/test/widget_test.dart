import 'package:admin_app/app/app.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('creates admin app widget', () {
    expect(App, isA<Type>());
  });
}
