import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'admin_users_localizations_en.dart';
import 'admin_users_localizations_kk.dart';
import 'admin_users_localizations_ru.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AdminUsersLocalizations
/// returned by `AdminUsersLocalizations.of(context)`.
///
/// Applications need to include `AdminUsersLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/admin_users_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AdminUsersLocalizations.localizationsDelegates,
///   supportedLocales: AdminUsersLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AdminUsersLocalizations.supportedLocales
/// property.
abstract class AdminUsersLocalizations {
  AdminUsersLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AdminUsersLocalizations of(BuildContext context) {
    return Localizations.of<AdminUsersLocalizations>(
      context,
      AdminUsersLocalizations,
    )!;
  }

  static const LocalizationsDelegate<AdminUsersLocalizations> delegate =
      _AdminUsersLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('kk'),
    Locale('ru'),
  ];

  /// No description provided for @usersTitle.
  ///
  /// In en, this message translates to:
  /// **'Users'**
  String get usersTitle;

  /// No description provided for @usersColumnEmail.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get usersColumnEmail;

  /// No description provided for @usersColumnRole.
  ///
  /// In en, this message translates to:
  /// **'Role'**
  String get usersColumnRole;

  /// No description provided for @usersColumnStatus.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get usersColumnStatus;

  /// No description provided for @usersColumnVerified.
  ///
  /// In en, this message translates to:
  /// **'Verified'**
  String get usersColumnVerified;

  /// No description provided for @usersColumnProfileCompleted.
  ///
  /// In en, this message translates to:
  /// **'Profile completed'**
  String get usersColumnProfileCompleted;

  /// No description provided for @usersColumnCreatedAt.
  ///
  /// In en, this message translates to:
  /// **'Created at'**
  String get usersColumnCreatedAt;

  /// No description provided for @usersEmpty.
  ///
  /// In en, this message translates to:
  /// **'No users found'**
  String get usersEmpty;

  /// No description provided for @usersLoadFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not load users'**
  String get usersLoadFailed;

  /// No description provided for @usersRefresh.
  ///
  /// In en, this message translates to:
  /// **'Refresh users'**
  String get usersRefresh;

  /// No description provided for @usersSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search users'**
  String get usersSearchHint;

  /// No description provided for @usersSearch.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get usersSearch;

  /// No description provided for @usersClearSearch.
  ///
  /// In en, this message translates to:
  /// **'Clear search'**
  String get usersClearSearch;

  /// No description provided for @usersFiltersLabel.
  ///
  /// In en, this message translates to:
  /// **'Filters'**
  String get usersFiltersLabel;

  /// No description provided for @usersFiltersClearAll.
  ///
  /// In en, this message translates to:
  /// **'Clear all'**
  String get usersFiltersClearAll;

  /// No description provided for @usersStatusFilterLabel.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get usersStatusFilterLabel;

  /// No description provided for @usersStatusFilterAll.
  ///
  /// In en, this message translates to:
  /// **'All statuses'**
  String get usersStatusFilterAll;

  /// No description provided for @usersRoleFilterLabel.
  ///
  /// In en, this message translates to:
  /// **'Role'**
  String get usersRoleFilterLabel;

  /// No description provided for @usersRoleFilterAll.
  ///
  /// In en, this message translates to:
  /// **'All roles'**
  String get usersRoleFilterAll;

  /// No description provided for @usersVerifiedFilterLabel.
  ///
  /// In en, this message translates to:
  /// **'Verified'**
  String get usersVerifiedFilterLabel;

  /// No description provided for @usersVerifiedFilterAll.
  ///
  /// In en, this message translates to:
  /// **'All verification'**
  String get usersVerifiedFilterAll;

  /// No description provided for @usersProfileCompletedFilterLabel.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get usersProfileCompletedFilterLabel;

  /// No description provided for @usersProfileCompletedFilterAll.
  ///
  /// In en, this message translates to:
  /// **'All profiles'**
  String get usersProfileCompletedFilterAll;

  /// No description provided for @usersCreatedAtFilterAll.
  ///
  /// In en, this message translates to:
  /// **'All dates'**
  String get usersCreatedAtFilterAll;

  /// No description provided for @usersActiveFilter.
  ///
  /// In en, this message translates to:
  /// **'{label}: {value}'**
  String usersActiveFilter(String label, String value);

  /// No description provided for @usersSearchResults.
  ///
  /// In en, this message translates to:
  /// **'Results for \"{search}\"'**
  String usersSearchResults(String search);

  /// No description provided for @usersRetry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get usersRetry;

  /// No description provided for @usersBack.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get usersBack;

  /// No description provided for @userTitle.
  ///
  /// In en, this message translates to:
  /// **'User'**
  String get userTitle;

  /// No description provided for @userLoadFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not load user'**
  String get userLoadFailed;

  /// No description provided for @userCardTitle.
  ///
  /// In en, this message translates to:
  /// **'User data'**
  String get userCardTitle;

  /// No description provided for @userProfileCardTitle.
  ///
  /// In en, this message translates to:
  /// **'Profile data'**
  String get userProfileCardTitle;

  /// No description provided for @userId.
  ///
  /// In en, this message translates to:
  /// **'User ID'**
  String get userId;

  /// No description provided for @userProfileFullName.
  ///
  /// In en, this message translates to:
  /// **'Full name'**
  String get userProfileFullName;

  /// No description provided for @userProfilePhone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get userProfilePhone;

  /// No description provided for @userProfileAvatar.
  ///
  /// In en, this message translates to:
  /// **'Avatar'**
  String get userProfileAvatar;

  /// No description provided for @userProfileCreatedAt.
  ///
  /// In en, this message translates to:
  /// **'Profile created at'**
  String get userProfileCreatedAt;

  /// No description provided for @userProfileUpdatedAt.
  ///
  /// In en, this message translates to:
  /// **'Profile updated at'**
  String get userProfileUpdatedAt;

  /// No description provided for @userProfileCompletedAt.
  ///
  /// In en, this message translates to:
  /// **'Profile completed at'**
  String get userProfileCompletedAt;

  /// No description provided for @userActionApproveDeletionRequest.
  ///
  /// In en, this message translates to:
  /// **'Approve deletion request'**
  String get userActionApproveDeletionRequest;

  /// No description provided for @userActionBlock.
  ///
  /// In en, this message translates to:
  /// **'Block user'**
  String get userActionBlock;

  /// No description provided for @userActionUnblock.
  ///
  /// In en, this message translates to:
  /// **'Unblock user'**
  String get userActionUnblock;

  /// No description provided for @usersPreviousPage.
  ///
  /// In en, this message translates to:
  /// **'Previous'**
  String get usersPreviousPage;

  /// No description provided for @usersNextPage.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get usersNextPage;

  /// No description provided for @usersPagination.
  ///
  /// In en, this message translates to:
  /// **'Page {page} of {totalPages}'**
  String usersPagination(int page, int totalPages);

  /// No description provided for @usersYes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get usersYes;

  /// No description provided for @usersNo.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get usersNo;

  /// No description provided for @usersRoleSuperAdmin.
  ///
  /// In en, this message translates to:
  /// **'Super admin'**
  String get usersRoleSuperAdmin;

  /// No description provided for @usersRoleAdmin.
  ///
  /// In en, this message translates to:
  /// **'Admin'**
  String get usersRoleAdmin;

  /// No description provided for @usersRoleUser.
  ///
  /// In en, this message translates to:
  /// **'User'**
  String get usersRoleUser;

  /// No description provided for @usersStatusActive.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get usersStatusActive;

  /// No description provided for @usersStatusBlocked.
  ///
  /// In en, this message translates to:
  /// **'Blocked'**
  String get usersStatusBlocked;

  /// No description provided for @usersStatusDeletionRequested.
  ///
  /// In en, this message translates to:
  /// **'Deletion requested'**
  String get usersStatusDeletionRequested;

  /// No description provided for @usersStatusDeleted.
  ///
  /// In en, this message translates to:
  /// **'Deleted'**
  String get usersStatusDeleted;
}

class _AdminUsersLocalizationsDelegate
    extends LocalizationsDelegate<AdminUsersLocalizations> {
  const _AdminUsersLocalizationsDelegate();

  @override
  Future<AdminUsersLocalizations> load(Locale locale) {
    return SynchronousFuture<AdminUsersLocalizations>(
      lookupAdminUsersLocalizations(locale),
    );
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'kk', 'ru'].contains(locale.languageCode);

  @override
  bool shouldReload(_AdminUsersLocalizationsDelegate old) => false;
}

AdminUsersLocalizations lookupAdminUsersLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AdminUsersLocalizationsEn();
    case 'kk':
      return AdminUsersLocalizationsKk();
    case 'ru':
      return AdminUsersLocalizationsRu();
  }

  throw FlutterError(
    'AdminUsersLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
