// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'admin_users_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Kazakh (`kk`).
class AdminUsersLocalizationsKk extends AdminUsersLocalizations {
  AdminUsersLocalizationsKk([String locale = 'kk']) : super(locale);

  @override
  String get usersTitle => 'Пайдаланушылар';

  @override
  String get usersColumnEmail => 'Электрондық пошта';

  @override
  String get usersColumnRole => 'Рөл';

  @override
  String get usersColumnStatus => 'Күй';

  @override
  String get usersColumnVerified => 'Расталған';

  @override
  String get usersColumnProfileCompleted => 'Профиль толтырылған';

  @override
  String get usersColumnCreatedAt => 'Құрылған күні';

  @override
  String get usersEmpty => 'Пайдаланушылар табылмады';

  @override
  String get usersLoadFailed => 'Пайдаланушыларды жүктеу мүмкін болмады';

  @override
  String get usersRefresh => 'Пайдаланушыларды жаңарту';

  @override
  String get usersSearchHint => 'Пайдаланушыларды іздеу';

  @override
  String get usersSearch => 'Іздеу';

  @override
  String get usersClearSearch => 'Іздеуді тазарту';

  @override
  String get usersFiltersLabel => 'Сүзгілер';

  @override
  String get usersFiltersClearAll => 'Барлығын тазарту';

  @override
  String get usersStatusFilterLabel => 'Күй';

  @override
  String get usersStatusFilterAll => 'Барлық күйлер';

  @override
  String get usersRoleFilterLabel => 'Рөл';

  @override
  String get usersRoleFilterAll => 'Барлық рөлдер';

  @override
  String get usersVerifiedFilterLabel => 'Расталған';

  @override
  String get usersVerifiedFilterAll => 'Барлық растау';

  @override
  String get usersProfileCompletedFilterLabel => 'Профиль';

  @override
  String get usersProfileCompletedFilterAll => 'Барлық профильдер';

  @override
  String get usersCreatedAtFilterAll => 'Барлық күндер';

  @override
  String usersActiveFilter(String label, String value) {
    return '$label: $value';
  }

  @override
  String usersSearchResults(String search) {
    return '\"$search\" бойынша нәтижелер';
  }

  @override
  String get usersRetry => 'Қайталау';

  @override
  String get usersBack => 'Артқа';

  @override
  String get userTitle => 'Пайдаланушы';

  @override
  String get userLoadFailed => 'Пайдаланушыны жүктеу мүмкін болмады';

  @override
  String get userCardTitle => 'Пайдаланушы деректері';

  @override
  String get userProfileCardTitle => 'Профиль деректері';

  @override
  String get userId => 'Пайдаланушы ID';

  @override
  String get userProfileFullName => 'Толық аты';

  @override
  String get userProfilePhone => 'Телефон';

  @override
  String get userProfileAvatar => 'Аватар';

  @override
  String get userProfileCreatedAt => 'Профиль құрылған күні';

  @override
  String get userProfileUpdatedAt => 'Профиль жаңартылған күні';

  @override
  String get userProfileCompletedAt => 'Профиль толтырылған күні';

  @override
  String get userActionApproveDeletionRequest => 'Жою сұрауын мақұлдау';

  @override
  String get userActionBlock => 'Пайдаланушыны бұғаттау';

  @override
  String get userActionUnblock => 'Пайдаланушыны бұғаттан шығару';

  @override
  String get usersPreviousPage => 'Артқа';

  @override
  String get usersNextPage => 'Келесі';

  @override
  String usersPagination(int page, int totalPages) {
    return '$totalPages беттің $page-беті';
  }

  @override
  String get usersYes => 'Иә';

  @override
  String get usersNo => 'Жоқ';

  @override
  String get usersRoleSuperAdmin => 'Супер әкімші';

  @override
  String get usersRoleAdmin => 'Әкімші';

  @override
  String get usersRoleUser => 'Пайдаланушы';

  @override
  String get usersStatusActive => 'Белсенді';

  @override
  String get usersStatusBlocked => 'Бұғатталған';

  @override
  String get usersStatusDeletionRequested => 'Жою сұралды';

  @override
  String get usersStatusDeleted => 'Жойылған';
}
