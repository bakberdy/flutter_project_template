import 'package:core/core.dart';
import 'package:client_auth/src/features/users/domain/entities/user_avatar_upload.dart';
import 'package:client_auth/src/features/users/domain/usecases/get_app_info_use_case.dart';
import 'package:client_auth/src/features/users/domain/usecases/get_current_user_profile_use_case.dart';
import 'package:client_auth/src/features/users/domain/usecases/get_current_user_use_case.dart';
import 'package:client_auth/src/features/users/domain/usecases/remove_user_avatar_use_case.dart';
import 'package:client_auth/src/features/users/domain/usecases/request_account_deletion_use_case.dart';
import 'package:client_auth/src/features/users/domain/usecases/update_user_avatar_use_case.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'user_profile_bloc.freezed.dart';
part 'user_profile_event.dart';
part 'user_profile_state.dart';

enum UserProfileAvatarAction { upload, remove }

@Injectable()
class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  final GetAppInfoUseCase _getAppInfoUseCase;
  final GetCurrentUserUseCase _getCurrentUserUseCase;
  final GetCurrentUserProfileUseCase _getCurrentUserProfileUseCase;
  final UpdateUserAvatarUseCase _updateUserAvatarUseCase;
  final RemoveUserAvatarUseCase _removeUserAvatarUseCase;
  final RequestAccountDeletionUseCase _requestAccountDeletionUseCase;
  final CoreAppConfig _appConfig;

  UserProfileBloc(
    this._getAppInfoUseCase,
    this._getCurrentUserUseCase,
    this._getCurrentUserProfileUseCase,
    this._updateUserAvatarUseCase,
    this._removeUserAvatarUseCase,
    this._requestAccountDeletionUseCase,
    this._appConfig,
  ) : super(const UserProfileState()) {
    on<UserProfileStarted>(_onStarted);
    on<UserProfileProfileLoaded>(_onProfileLoaded);
    on<UserProfileAvatarUploadRequested>(_onAvatarUploadRequested);
    on<UserProfileAvatarRemoveRequested>(_onAvatarRemoveRequested);
    on<UserProfileAvatarStatusReset>(_onAvatarStatusReset);
    on<UserProfileAccountDeletionRequested>(_onAccountDeletionRequested);
    on<UserProfileAccountDeletionStatusReset>(_onAccountDeletionStatusReset);
  }

  Future<void> _onStarted(
    UserProfileStarted event,
    Emitter<UserProfileState> emit,
  ) async {
    emit(state.copyWith(status: const StateStatus.loading()));

    final result = await _getAppInfoUseCase(const NoParams());
    result.fold(
      (failure) => emit(state.copyWith(status: StateStatus.error(failure))),
      (appInfo) => emit(
        state.copyWith(
          appInfo: appInfo,
          showAppBuildDetails:
              kDebugMode || _appConfig.environment == 'development',
          status: const StateStatus.success(),
        ),
      ),
    );

    final userResult = await _getCurrentUserUseCase((
      cancelToken: null,
      timeout: null,
    ));
    userResult.fold((_) {}, (user) => emit(state.copyWith(user: user)));

    emit(state.copyWith(profileStatus: const StateStatus.loading()));
    final profileResult = await _getCurrentUserProfileUseCase(null);
    profileResult.fold(
      (failure) =>
          emit(state.copyWith(profileStatus: StateStatus.error(failure))),
      (profile) => emit(
        state.copyWith(
          profile: profile,
          profileStatus: const StateStatus.success(),
        ),
      ),
    );
  }

  Future<void> _onProfileLoaded(
    UserProfileProfileLoaded event,
    Emitter<UserProfileState> emit,
  ) async {
    final result = await _getCurrentUserProfileUseCase(null);
    result.fold(
      (failure) =>
          emit(state.copyWith(profileStatus: StateStatus.error(failure))),
      (profile) => emit(
        state.copyWith(
          profile: profile,
          profileStatus: const StateStatus.success(),
        ),
      ),
    );
  }

  Future<void> _onAvatarUploadRequested(
    UserProfileAvatarUploadRequested event,
    Emitter<UserProfileState> emit,
  ) async {
    emit(
      state.copyWith(
        avatarStatus: const StateStatus.loading(),
        avatarUploadProgress: null,
        avatarAction: UserProfileAvatarAction.upload,
      ),
    );

    final result = await _updateUserAvatarUseCase(
      UpdateUserAvatarParams(
        avatar: event.avatar,
        onSendProgress: (sent, total) {
          if (total <= 0) {
            return;
          }
          emit(state.copyWith(avatarUploadProgress: sent / total));
        },
      ),
    );

    result.fold(
      (failure) => emit(
        state.copyWith(
          avatarStatus: StateStatus.error(failure),
          avatarUploadProgress: null,
        ),
      ),
      (profile) => emit(
        state.copyWith(
          profile: profile,
          profileStatus: const StateStatus.success(),
          avatarStatus: const StateStatus.success(),
          avatarUploadProgress: null,
        ),
      ),
    );
  }

  Future<void> _onAvatarRemoveRequested(
    UserProfileAvatarRemoveRequested event,
    Emitter<UserProfileState> emit,
  ) async {
    emit(
      state.copyWith(
        avatarStatus: const StateStatus.loading(),
        avatarUploadProgress: null,
        avatarAction: UserProfileAvatarAction.remove,
      ),
    );

    final result = await _removeUserAvatarUseCase(const NoParams());
    result.fold(
      (failure) =>
          emit(state.copyWith(avatarStatus: StateStatus.error(failure))),
      (profile) => emit(
        state.copyWith(
          profile: profile,
          profileStatus: const StateStatus.success(),
          avatarStatus: const StateStatus.success(),
        ),
      ),
    );
  }

  void _onAvatarStatusReset(
    UserProfileAvatarStatusReset event,
    Emitter<UserProfileState> emit,
  ) {
    emit(
      state.copyWith(
        avatarStatus: const StateStatus.initial(),
        avatarUploadProgress: null,
        avatarAction: null,
      ),
    );
  }

  Future<void> _onAccountDeletionRequested(
    UserProfileAccountDeletionRequested event,
    Emitter<UserProfileState> emit,
  ) async {
    emit(state.copyWith(accountDeletionStatus: const StateStatus.loading()));

    final result = await _requestAccountDeletionUseCase(const NoParams());
    result.fold(
      (failure) => emit(
        state.copyWith(accountDeletionStatus: StateStatus.error(failure)),
      ),
      (_) => emit(
        state.copyWith(accountDeletionStatus: const StateStatus.success()),
      ),
    );
  }

  void _onAccountDeletionStatusReset(
    UserProfileAccountDeletionStatusReset event,
    Emitter<UserProfileState> emit,
  ) {
    emit(state.copyWith(accountDeletionStatus: const StateStatus.initial()));
  }
}
