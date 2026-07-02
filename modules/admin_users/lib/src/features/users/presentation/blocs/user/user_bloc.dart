import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:admin_users/src/features/users/domain/entities/admin_user.dart';
import 'package:admin_users/src/features/users/domain/entities/admin_user_profile.dart';
import 'package:admin_users/src/features/users/domain/usecases/approve_user_deletion_request_use_case.dart';
import 'package:admin_users/src/features/users/domain/usecases/change_user_status_use_case.dart';
import 'package:admin_users/src/features/users/domain/usecases/get_user_profile_use_case.dart';
import 'package:admin_users/src/features/users/domain/usecases/get_user_use_case.dart';

part 'user_bloc.freezed.dart';
part 'user_event.dart';
part 'user_state.dart';

@injectable
class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc(
    this._getUserUseCase,
    this._getUserProfileUseCase,
    this._changeUserStatusUseCase,
    this._approveUserDeletionRequestUseCase,
  ) : super(const UserState()) {
    on<_Started>(_onStarted, transformer: restartable());
    on<_DeletionApproved>(_onDeletionApproved, transformer: droppable());
    on<_Blocked>(_onBlocked, transformer: droppable());
    on<_Unblocked>(_onUnblocked, transformer: droppable());
  }

  final GetUserUseCase _getUserUseCase;
  final GetUserProfileUseCase _getUserProfileUseCase;
  final ChangeUserStatusUseCase _changeUserStatusUseCase;
  final ApproveUserDeletionRequestUseCase _approveUserDeletionRequestUseCase;
  ApiCancelToken? _userCancelToken;
  ApiCancelToken? _profileCancelToken;

  Future<void> _onStarted(_Started event, Emitter<UserState> emit) async {
    _userCancelToken?.cancel();
    _profileCancelToken?.cancel();
    final userCancelToken = ApiCancelToken();
    final profileCancelToken = ApiCancelToken();
    _userCancelToken = userCancelToken;
    _profileCancelToken = profileCancelToken;

    emit(const UserState(status: StateStatus.loading()));

    final userResult = await _getUserUseCase((
      userId: event.userId,
      cancelToken: userCancelToken,
    ));

    if (identical(_userCancelToken, userCancelToken)) {
      _userCancelToken = null;
    }

    await userResult.fold<Future<void>>(
      (failure) async {
        if (failure.details?.type == FailureType.silent) {
          return;
        }
        emit(state.copyWith(status: StateStatus.error(failure)));
      },
      (loadedUser) async {
        if (!loadedUser.isUserDataUploaded) {
          _profileCancelToken?.cancel();
          _profileCancelToken = null;
          emit(
            state.copyWith(
              status: const StateStatus.success(),
              user: loadedUser,
            ),
          );
          return;
        }

        final profileResult = await _getUserProfileUseCase((
          userId: event.userId,
          cancelToken: profileCancelToken,
        ));

        if (identical(_profileCancelToken, profileCancelToken)) {
          _profileCancelToken = null;
        }

        profileResult.fold(
          (failure) {
            if (failure.details?.type == FailureType.silent) {
              return;
            }
            emit(state.copyWith(status: StateStatus.error(failure)));
          },
          (loadedProfile) {
            emit(
              state.copyWith(
                status: const StateStatus.success(),
                user: loadedUser,
                profile: loadedProfile,
              ),
            );
          },
        );
      },
    );
  }

  Future<void> _onDeletionApproved(
    _DeletionApproved event,
    Emitter<UserState> emit,
  ) async {
    emit(state.copyWith(actionStatus: const StateStatus.loading()));
    final result = await _approveUserDeletionRequestUseCase(event.userId);
    result.fold(
      (failure) =>
          emit(state.copyWith(actionStatus: StateStatus.error(failure))),
      (user) => emit(
        state.copyWith(user: user, actionStatus: const StateStatus.success()),
      ),
    );
  }

  Future<void> _onBlocked(_Blocked event, Emitter<UserState> emit) async {
    await _changeStatus(event.userId, AdminUserStatus.blocked, emit);
  }

  Future<void> _onUnblocked(_Unblocked event, Emitter<UserState> emit) async {
    await _changeStatus(event.userId, AdminUserStatus.active, emit);
  }

  Future<void> _changeStatus(
    String userId,
    AdminUserStatus status,
    Emitter<UserState> emit,
  ) async {
    emit(state.copyWith(actionStatus: const StateStatus.loading()));
    final result = await _changeUserStatusUseCase((
      userId: userId,
      status: status,
    ));
    result.fold(
      (failure) =>
          emit(state.copyWith(actionStatus: StateStatus.error(failure))),
      (user) => emit(
        state.copyWith(user: user, actionStatus: const StateStatus.success()),
      ),
    );
  }

  @override
  Future<void> close() {
    _userCancelToken?.cancel();
    _profileCancelToken?.cancel();
    return super.close();
  }
}
