part of 'user_profile_bloc.dart';

@freezed
sealed class UserProfileEvent with _$UserProfileEvent {
  const factory UserProfileEvent.started() = UserProfileStarted;

  const factory UserProfileEvent.profileLoaded() = UserProfileProfileLoaded;

  const factory UserProfileEvent.avatarUploadRequested(
    AppPickedFile avatar,
  ) = UserProfileAvatarUploadRequested;

  const factory UserProfileEvent.avatarRemoveRequested() =
      UserProfileAvatarRemoveRequested;

  const factory UserProfileEvent.avatarStatusReset() =
      UserProfileAvatarStatusReset;

  const factory UserProfileEvent.accountDeletionRequested() =
      UserProfileAccountDeletionRequested;

  const factory UserProfileEvent.accountDeletionStatusReset() =
      UserProfileAccountDeletionStatusReset;
}
