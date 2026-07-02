// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'admin_users_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AdminUsersLocalizationsRu extends AdminUsersLocalizations {
  AdminUsersLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get usersTitle => 'Пользователи';

  @override
  String get usersColumnEmail => 'Электронная почта';

  @override
  String get usersColumnRole => 'Роль';

  @override
  String get usersColumnStatus => 'Статус';

  @override
  String get usersColumnVerified => 'Подтвержден';

  @override
  String get usersColumnProfileCompleted => 'Профиль заполнен';

  @override
  String get usersColumnCreatedAt => 'Дата создания';

  @override
  String get usersEmpty => 'Пользователи не найдены';

  @override
  String get usersLoadFailed => 'Не удалось загрузить пользователей';

  @override
  String get usersRefresh => 'Обновить пользователей';

  @override
  String get usersSearchHint => 'Поиск пользователей';

  @override
  String get usersSearch => 'Найти';

  @override
  String get usersClearSearch => 'Очистить поиск';

  @override
  String get usersFiltersLabel => 'Фильтры';

  @override
  String get usersFiltersClearAll => 'Сбросить все';

  @override
  String get usersStatusFilterLabel => 'Статус';

  @override
  String get usersStatusFilterAll => 'Все статусы';

  @override
  String get usersRoleFilterLabel => 'Роль';

  @override
  String get usersRoleFilterAll => 'Все роли';

  @override
  String get usersVerifiedFilterLabel => 'Подтвержден';

  @override
  String get usersVerifiedFilterAll => 'Все подтверждения';

  @override
  String get usersProfileCompletedFilterLabel => 'Профиль';

  @override
  String get usersProfileCompletedFilterAll => 'Все профили';

  @override
  String get usersCreatedAtFilterAll => 'Все даты';

  @override
  String usersSearchResults(String search) {
    return 'Результаты для \"$search\"';
  }

  @override
  String get usersRetry => 'Повторить';

  @override
  String get usersBack => 'Назад';

  @override
  String get userTitle => 'Пользователь';

  @override
  String get userLoadFailed => 'Не удалось загрузить пользователя';

  @override
  String get userCardTitle => 'Данные пользователя';

  @override
  String get userProfileCardTitle => 'Данные профиля';

  @override
  String get userId => 'ID пользователя';

  @override
  String get userProfileFullName => 'Полное имя';

  @override
  String get userProfilePhone => 'Телефон';

  @override
  String get userProfileAvatar => 'Аватар';

  @override
  String get userProfileCreatedAt => 'Профиль создан';

  @override
  String get userProfileUpdatedAt => 'Профиль обновлен';

  @override
  String get userProfileCompletedAt => 'Профиль заполнен';

  @override
  String get userActionApproveDeletionRequest => 'Одобрить запрос на удаление';

  @override
  String get userActionBlock => 'Заблокировать пользователя';

  @override
  String get userActionUnblock => 'Разблокировать пользователя';

  @override
  String get usersPreviousPage => 'Назад';

  @override
  String get usersNextPage => 'Далее';

  @override
  String usersPagination(int page, int totalPages) {
    return 'Страница $page из $totalPages';
  }

  @override
  String get usersYes => 'Да';

  @override
  String get usersNo => 'Нет';

  @override
  String get usersRoleSuperAdmin => 'Суперадминистратор';

  @override
  String get usersRoleAdmin => 'Администратор';

  @override
  String get usersRoleUser => 'Пользователь';

  @override
  String get usersStatusActive => 'Активен';

  @override
  String get usersStatusBlocked => 'Заблокирован';

  @override
  String get usersStatusDeletionRequested => 'Запрошено удаление';

  @override
  String get usersStatusDeleted => 'Удален';
}
