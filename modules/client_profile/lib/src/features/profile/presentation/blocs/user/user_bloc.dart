import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:client_profile/client_profile.dart';
import 'package:core/api/models/api_cancel_token.dart';
import 'package:core/bloc/state_status/state_status.dart';
import 'package:core/usecases/use_case.dart';
import 'package:shared/shared.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:client_profile/src/features/profile/domain/usecases/get_current_user_use_case.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'user_event.dart';
part 'user_state.dart';
part 'user_bloc.freezed.dart';

const _requestTimeout = Duration(seconds: 10);

@injectable
class UserBloc extends Bloc<UserEvent, UserState> {
  final GetCurrentUserUseCase getUserUseCase;
  final LogOutUseCase logOutUseCase;

  UserBloc(this.getUserUseCase, this.logOutUseCase) : super(UserState()) {
    on<UserEvent>(_onEvent, transformer: restartable());
  }

  ApiCancelToken? _getCurrentUserCancelToken;

  Future<void> _onEvent(UserEvent event, Emitter<UserState> emit) async {
    switch (event) {
      case UserRefreshEvent():
        await _getCurrentUser(emit);
        return;
      case UserLoggedOutEvent():
        _getCurrentUserCancelToken?.cancel();
        _getCurrentUserCancelToken = null;
        final result = await logOutUseCase(const NoParams());

        result.fold(
          (failure) => emit(state.copyWith(status: StateStatus.error(failure))),
          (_) => emit(UserState(status: StateStatus.success())),
        );
        return;
    }
  }

  Future<void> _getCurrentUser(Emitter<UserState> emit) async {
    _getCurrentUserCancelToken?.cancel();
    _getCurrentUserCancelToken = ApiCancelToken();

    emit(state.copyWith(status: StateStatus.loading()));

    final result = await getUserUseCase((
      cancelToken: _getCurrentUserCancelToken,
      timeout: _requestTimeout,
    ));

    if (emit.isDone) return;

    result.fold(
      (failure) => emit(state.copyWith(status: StateStatus.error(failure))),
      (user) => emit(state.copyWith(user: user, status: StateStatus.success())),
    );
  }

  @override
  Future<void> close() {
    _getCurrentUserCancelToken?.cancel();
    return super.close();
  }
}
