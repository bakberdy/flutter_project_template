// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'admin_users_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AdminUsersLocalizationsEn extends AdminUsersLocalizations {
  AdminUsersLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get usersTitle => 'Users';

  @override
  String get usersColumnEmail => 'Email';

  @override
  String get usersColumnRole => 'Role';

  @override
  String get usersColumnStatus => 'Status';

  @override
  String get usersColumnVerified => 'Verified';

  @override
  String get usersColumnProfileCompleted => 'Profile completed';

  @override
  String get usersColumnCreatedAt => 'Created at';

  @override
  String get usersEmpty => 'No users found';

  @override
  String get usersLoadFailed => 'Could not load users';

  @override
  String get usersRefresh => 'Refresh users';

  @override
  String get usersSearchHint => 'Search users';

  @override
  String get usersSearch => 'Search';

  @override
  String get usersClearSearch => 'Clear search';

  @override
  String get usersFiltersLabel => 'Filters';

  @override
  String get usersFiltersClearAll => 'Clear all';

  @override
  String get usersStatusFilterLabel => 'Status';

  @override
  String get usersStatusFilterAll => 'All statuses';

  @override
  String get usersRoleFilterLabel => 'Role';

  @override
  String get usersRoleFilterAll => 'All roles';

  @override
  String get usersVerifiedFilterLabel => 'Verified';

  @override
  String get usersVerifiedFilterAll => 'All verification';

  @override
  String get usersProfileCompletedFilterLabel => 'Profile';

  @override
  String get usersProfileCompletedFilterAll => 'All profiles';

  @override
  String get usersCreatedAtFilterAll => 'All dates';

  @override
  String usersSearchResults(String search) {
    return 'Results for \"$search\"';
  }

  @override
  String get usersRetry => 'Retry';

  @override
  String get usersBack => 'Back';

  @override
  String get userTitle => 'User';

  @override
  String get userLoadFailed => 'Could not load user';

  @override
  String get userCardTitle => 'User data';

  @override
  String get userProfileCardTitle => 'Profile data';

  @override
  String get userId => 'User ID';

  @override
  String get userProfileFullName => 'Full name';

  @override
  String get userProfilePhone => 'Phone';

  @override
  String get userProfileAvatar => 'Avatar';

  @override
  String get userProfileCreatedAt => 'Profile created at';

  @override
  String get userProfileUpdatedAt => 'Profile updated at';

  @override
  String get userProfileCompletedAt => 'Profile completed at';

  @override
  String get userActionApproveDeletionRequest => 'Approve deletion request';

  @override
  String get userActionBlock => 'Block user';

  @override
  String get userActionUnblock => 'Unblock user';

  @override
  String get usersPreviousPage => 'Previous';

  @override
  String get usersNextPage => 'Next';

  @override
  String usersPagination(int page, int totalPages) {
    return 'Page $page of $totalPages';
  }

  @override
  String get usersYes => 'Yes';

  @override
  String get usersNo => 'No';

  @override
  String get usersRoleSuperAdmin => 'Super admin';

  @override
  String get usersRoleAdmin => 'Admin';

  @override
  String get usersRoleUser => 'User';

  @override
  String get usersStatusActive => 'Active';

  @override
  String get usersStatusBlocked => 'Blocked';

  @override
  String get usersStatusDeletionRequested => 'Deletion requested';

  @override
  String get usersStatusDeleted => 'Deleted';
}
