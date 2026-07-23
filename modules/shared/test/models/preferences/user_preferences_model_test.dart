import 'package:flutter_test/flutter_test.dart';
import 'package:shared/shared.dart';

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

  test('creates a model from the shared entity', () {
    final entity = UserPreferences(
      userId: 'user-id',
      language: UserLanguage.ru,
      theme: UserTheme.light,
      pushNotificationsEnabled: false,
      emailNotificationsEnabled: true,
      marketingNotificationsEnabled: false,
      createdAt: DateTime.utc(2026, 7, 13, 10),
      updatedAt: DateTime.utc(2026, 7, 13, 11),
    );

    final model = UserPreferencesModel.fromEntity(entity);

    expect(model.userId, entity.userId);
    expect(model.language, entity.language);
    expect(model.theme, entity.theme);
    expect(
      model.pushNotificationsEnabled,
      entity.pushNotificationsEnabled,
    );
    expect(
      model.emailNotificationsEnabled,
      entity.emailNotificationsEnabled,
    );
    expect(
      model.marketingNotificationsEnabled,
      entity.marketingNotificationsEnabled,
    );
    expect(model.createdAt, entity.createdAt);
    expect(model.updatedAt, entity.updatedAt);
  });
}
