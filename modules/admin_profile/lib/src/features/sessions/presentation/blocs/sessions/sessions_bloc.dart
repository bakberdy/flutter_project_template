import 'package:admin_profile/src/features/sessions/domain/entities/session.dart';
import 'package:admin_profile/src/features/sessions/domain/usecases/get_sessions_use_case.dart';
import 'package:admin_profile/src/features/sessions/domain/usecases/revoke_all_sessions_use_case.dart';
import 'package:admin_profile/src/features/sessions/domain/usecases/revoke_session_use_case.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'sessions_bloc.freezed.dart';
part 'sessions_event.dart';
part 'sessions_state.dart';

@injectable
class SessionsBloc extends Bloc<SessionsEvent, SessionsState> {
  SessionsBloc(
    this._getSessionsUseCase,
    this._revokeSessionUseCase,
    this._revokeAllSessionsUseCase,
  ) : super(const SessionsState()) {
    on<_Started>(_onStarted, transformer: restartable());
    on<_Refreshed>(_onRefreshed, transformer: restartable());
    on<_SessionRevokeRequested>(
      _onSessionRevokeRequested,
      transformer: sequential(),
    );
    on<_RevokeAllRequested>(_onRevokeAllRequested, transformer: sequential());
    on<_TransientFailureAcknowledged>(_onTransientFailureAcknowledged);
  }

  final GetSessionsUseCase _getSessionsUseCase;
  final RevokeSessionUseCase _revokeSessionUseCase;
  final RevokeAllSessionsUseCase _revokeAllSessionsUseCase;

  Future<void> _onStarted(_Started event, Emitter<SessionsState> emit) =>
      _fetchFirstPage(emit);

  Future<void> _onRefreshed(_Refreshed event, Emitter<SessionsState> emit) =>
      _fetchFirstPage(emit);

  Future<void> _fetchFirstPage(Emitter<SessionsState> emit) async {
    emit(
      state.copyWith(
        listStatus: const StateStatus.loading(),
        transientActionFailure: null,
      ),
    );
    final result = await _getSessionsUseCase.call((
      pageNumber: 1,
      limit: 20,
      isActive: null,
    ));

    result.fold(
      (failure) {
        if (failure.details?.type == FailureType.silent) {
          emit(state.copyWith(listStatus: const StateStatus.initial()));
          return;
        }
        emit(state.copyWith(listStatus: StateStatus.error(failure)));
      },
      (PaginatedResponse<Session> paginated) {
        emit(
          state.copyWith(
            listStatus: const StateStatus.success(),
            sessions: paginated.items,
          ),
        );
      },
    );
  }

  Future<void> _onSessionRevokeRequested(
    _SessionRevokeRequested event,
    Emitter<SessionsState> emit,
  ) async {
    if (state.revokingAll || state.revokingSessionId != null) {
      return;
    }

    emit(
      state.copyWith(
        revokingSessionId: event.sessionId,
        transientActionFailure: null,
      ),
    );

    final result = await _revokeSessionUseCase(event.sessionId);
    result.fold(
      (failure) {
        emit(
          state.copyWith(
            revokingSessionId: null,
            transientActionFailure: failure,
          ),
        );
      },
      (_) {
        emit(
          state.copyWith(
            revokingSessionId: null,
            sessions: state.sessions
                .where((s) => s.id != event.sessionId)
                .toList(),
          ),
        );
      },
    );
  }

  Future<void> _onRevokeAllRequested(
    _RevokeAllRequested event,
    Emitter<SessionsState> emit,
  ) async {
    if (state.revokingAll || state.revokingSessionId != null) {
      return;
    }

    emit(state.copyWith(revokingAll: true, transientActionFailure: null));
    final result = await _revokeAllSessionsUseCase(const NoParams());
    result.fold(
      (failure) {
        emit(
          state.copyWith(revokingAll: false, transientActionFailure: failure),
        );
      },
      (_) {
        emit(
          state.copyWith(
            revokingAll: false,
            sessions: [],
            navigateToAuthAfterRevokeAll: true,
            listStatus: const StateStatus.success(),
          ),
        );
      },
    );
  }

  void _onTransientFailureAcknowledged(
    _TransientFailureAcknowledged event,
    Emitter<SessionsState> emit,
  ) {
    emit(state.copyWith(transientActionFailure: null));
  }
}
