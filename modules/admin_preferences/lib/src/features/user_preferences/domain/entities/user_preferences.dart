import 'package:equatable/equatable.dart';

enum UserLanguage {
  en,
  ru,
  kk;

  static UserLanguage? fromLanguageCode(String? value) => switch (value) {
    'en' => UserLanguage.en,
    'ru' => UserLanguage.ru,
    'kk' => UserLanguage.kk,
    _ => null,
  };

  String get languageCode => name;
}

enum UserTheme { system, light, dark }

class UserPreferences extends Equatable {
  final String userId;
  final UserLanguage language;
  final UserTheme theme;
  final bool pushNotificationsEnabled;
  final bool emailNotificationsEnabled;
  final bool marketingNotificationsEnabled;
  final DateTime createdAt;
  final DateTime updatedAt;

  const UserPreferences({
    required this.userId,
    required this.language,
    required this.theme,
    required this.pushNotificationsEnabled,
    required this.emailNotificationsEnabled,
    required this.marketingNotificationsEnabled,
    required this.createdAt,
    required this.updatedAt,
  });

  UserPreferences copyWith({
    String? userId,
    UserLanguage? language,
    UserTheme? theme,
    bool? pushNotificationsEnabled,
    bool? emailNotificationsEnabled,
    bool? marketingNotificationsEnabled,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserPreferences(
      userId: userId ?? this.userId,
      language: language ?? this.language,
      theme: theme ?? this.theme,
      pushNotificationsEnabled:
          pushNotificationsEnabled ?? this.pushNotificationsEnabled,
      emailNotificationsEnabled:
          emailNotificationsEnabled ?? this.emailNotificationsEnabled,
      marketingNotificationsEnabled:
          marketingNotificationsEnabled ?? this.marketingNotificationsEnabled,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
    userId,
    language,
    theme,
    pushNotificationsEnabled,
    emailNotificationsEnabled,
    marketingNotificationsEnabled,
    createdAt,
    updatedAt,
  ];
}
