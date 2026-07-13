import 'package:admin_preferences/src/features/user_preferences/data/models/user_preferences_model/user_preferences_model.dart';
import 'package:admin_preferences/src/features/user_preferences/domain/entities/user_preferences.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('parses and serializes the preferences API contract', () {
    final json = <String, dynamic>{
      'user_id': 'user-id',
      'language': 'kk',
      'theme': 'dark',
      'push_notifications_enabled': true,
      'email_notifications_enabled': false,
      'marketing_notifications_enabled': true,
      'created_at': '2026-07-13T10:00:00.000Z',
      'updated_at': '2026-07-13T11:00:00.000Z',
    };

    final model = UserPreferencesModel.fromJson(json);

    expect(model.language, UserLanguage.kk);
    expect(model.theme, UserTheme.dark);
    expect(model.toJson(), json);
  });
}
