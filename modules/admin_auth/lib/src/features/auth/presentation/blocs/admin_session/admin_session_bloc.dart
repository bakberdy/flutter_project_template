import 'package:admin_auth/src/features/auth/domain/usecases/auth_log_out_use_case.dart';
import 'package:admin_auth/src/features/auth/domain/usecases/get_admin_session_use_case.dart';
import 'package:core/core.dart';
import 'package:shared/shared.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'admin_session_event.dart';
part 'admin_session_state.dart';

@injectable
class AdminSessionBloc extends Bloc<AdminSessionEvent, AdminSessionState> {
  AdminSessionBloc(this._getSession, this._logOut)
    : super(const AdminSessionState()) {
    on<AdminSessionStarted>(_onStarted);
    on<AdminSessionLogoutRequested>(_onLogoutRequested);
    on<AdminSessionFailureAcknowledged>(
      (_, emit) => emit(state.copyWith(clearLaunchFailure: true)),
    );
    on<AdminSessionAccessDeniedAcknowledged>(
      (_, emit) => emit(state.copyWith(accessDenied: false)),
    );
  }

  final GetAdminSessionUseCase _getSession;
  final AuthLogOutUseCase _logOut;

  Future<void> _onStarted(
    AdminSessionStarted event,
    Emitter<AdminSessionState> emit,
  ) async {
    emit(state.copyWith(status: const StateStatus.loading()));
    final result = await _getSession(const NoParams());
    if (emit.isDone) return;

    result.fold(
      (failure) => emit(
        state.copyWith(
          user: null,
          hasSession: true,
          launchFailure: failure,
          status: StateStatus.error(failure),
        ),
      ),
      (session) => emit(
        state.copyWith(
          user: session.user,
          clearUser: session.user == null,
          hasSession: session.user != null,
          accessDenied: session.accessDenied,
          clearLaunchFailure: true,
          status: const StateStatus.success(),
        ),
      ),
    );
  }

  Future<void> _onLogoutRequested(
    AdminSessionLogoutRequested event,
    Emitter<AdminSessionState> emit,
  ) async {
    emit(state.copyWith(status: const StateStatus.loading()));
    await _logOut(const NoParams());
    if (emit.isDone) return;
    emit(const AdminSessionState(status: StateStatus.success()));
  }
}
