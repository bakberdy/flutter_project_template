import 'package:admin_profile/src/features/profile/domain/usecases/get_current_user_use_case.dart';
import 'package:admin_profile/src/features/profile/domain/usecases/log_out_use_case.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/shared.dart';

part 'user_event.dart';
part 'user_state.dart';
part 'user_bloc.freezed.dart';

const _requestTimeout = Duration(seconds: 10);

@injectable
class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc(this._getUserUseCase, this._logOutUseCase)
    : super(const UserState()) {
    on<UserEvent>(_onEvent, transformer: restartable());
  }

  final GetCurrentUserUseCase _getUserUseCase;
  final LogOutUseCase _logOutUseCase;
  ApiCancelToken? _getCurrentUserCancelToken;

  Future<void> _onEvent(UserEvent event, Emitter<UserState> emit) async {
    switch (event) {
      case UserRefreshEvent():
        await _getCurrentUser(emit);
        return;
      case UserLoggedOutEvent():
        _getCurrentUserCancelToken?.cancel();
        _getCurrentUserCancelToken = null;
        final result = await _logOutUseCase(const NoParams());
        if (emit.isDone) return;
        result.fold(
          (failure) => emit(state.copyWith(status: StateStatus.error(failure))),
          (_) => emit(const UserState(status: StateStatus.success())),
        );
        return;
      case UserAccessDeniedAcknowledgedEvent():
        emit(state.copyWith(accessDenied: false));
        return;
    }
  }

  Future<void> _getCurrentUser(Emitter<UserState> emit) async {
    _getCurrentUserCancelToken?.cancel();
    _getCurrentUserCancelToken = ApiCancelToken();
    emit(state.copyWith(status: const StateStatus.loading()));

    final result = await _getUserUseCase((
      cancelToken: _getCurrentUserCancelToken,
      timeout: _requestTimeout,
    ));
    if (emit.isDone) return;

    result.fold(
      (failure) => emit(state.copyWith(status: StateStatus.error(failure))),
      (result) => emit(
        state.copyWith(
          user: result.user,
          accessDenied: result.accessDenied,
          status: const StateStatus.success(),
        ),
      ),
    );
  }

  @override
  Future<void> close() {
    _getCurrentUserCancelToken?.cancel();
    return super.close();
  }
}
