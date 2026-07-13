part of 'user_profile_bloc.dart';

@freezed
sealed class UserProfileState with _$UserProfileState {
  const factory UserProfileState({
    UserProfile? profile,
    @Default(StateStatus.initial()) StateStatus profileStatus,
    @Default(StateStatus.initial()) StateStatus avatarStatus,
    @Default(StateStatus.initial()) StateStatus accountDeletionStatus,
    double? avatarUploadProgress,
    UserProfileAvatarAction? avatarAction,
  }) = _UserProfileState;
}
