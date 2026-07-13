import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:admin_profile/src/features/profile/domain/usecases/get_current_user_use_case.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'user_event.dart';
part 'user_state.dart';
part 'user_bloc.freezed.dart';

const _requestTimeout = Duration(seconds: 3);

@injectable
class UserBloc extends Bloc<UserEvent, UserState> {
  final GetCurrentUserUseCase getUserUseCase;
  final TokenStorage _tokenStorage;

  UserBloc(this.getUserUseCase, this._tokenStorage) : super(const UserState()) {
    on<UserStartedEvent>((event, emit) => _getCurrentUser(emit));
    on<UserLaunchFailureAcknowledgedEvent>(
      (event, emit) => emit(state.copyWith(launchFailure: null)),
    );
  }

  ApiCancelToken? _getCurrentUserCancelToken;

  Future<void> _getCurrentUser(Emitter<UserState> emit) async {
    _getCurrentUserCancelToken?.cancel();
    _getCurrentUserCancelToken = ApiCancelToken();

    emit(state.copyWith(status: const StateStatus.loading()));

    final token = await _tokenStorage.getAccessToken();
    if (token == null || token.isEmpty) {
      emit(
        state.copyWith(
          user: null,
          hasSession: false,
          launchFailure: null,
          status: const StateStatus.success(),
        ),
      );
      return;
    }

    final result = await getUserUseCase((
      cancelToken: _getCurrentUserCancelToken,
      timeout: _requestTimeout,
    ));

    if (emit.isDone) return;

    result.fold(
      (failure) => emit(
        state.copyWith(
          user: null,
          hasSession: true,
          launchFailure: _isConnectionFailure(failure) ? failure : null,
          status: const StateStatus.success(),
        ),
      ),
      (user) => emit(
        state.copyWith(
          user: user,
          hasSession: true,
          launchFailure: null,
          status: const StateStatus.success(),
        ),
      ),
    );
  }

  bool _isConnectionFailure(Failure failure) =>
      failure.details?.statusCode == 0 &&
      failure.details?.type == FailureType.snackbar;

  @override
  Future<void> close() {
    _getCurrentUserCancelToken?.cancel();
    return super.close();
  }
}
