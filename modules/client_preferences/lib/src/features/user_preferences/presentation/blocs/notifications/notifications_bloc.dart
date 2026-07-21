import 'package:client_preferences/src/features/user_preferences/domain/entities/user_preferences.dart';
import 'package:client_preferences/src/features/user_preferences/domain/usecases/get_user_preferences_use_case.dart';
import 'package:client_preferences/src/features/user_preferences/domain/usecases/set_user_notifications_use_case.dart';
import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'notifications_bloc.freezed.dart';
part 'notifications_event.dart';
part 'notifications_state.dart';

@Injectable()
class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  NotificationsBloc(
    this._getUserPreferencesUseCase,
    this._setUserNotificationsUseCase,
  ) : super(const NotificationsState()) {
    on<NotificationsStarted>(_onStarted);
    on<NotificationsChanged>(_onChanged);
  }
  final GetUserPreferencesUseCase _getUserPreferencesUseCase;
  final SetUserNotificationsUseCase _setUserNotificationsUseCase;

  Future<void> _onStarted(
    NotificationsStarted event,
    Emitter<NotificationsState> emit,
  ) async {
    emit(state.copyWith(status: const StateStatus.loading()));

    final result = await _getUserPreferencesUseCase(const NoParams());
    result.fold(
      (Failure failure) {
        emit(state.copyWith(status: StateStatus.error(failure)));
      },
      (preferences) {
        emit(
          state.copyWith(
            preferences: preferences ?? _defaultPreferences(),
            status: const StateStatus.success(),
          ),
        );
      },
    );
  }

  Future<void> _onChanged(
    NotificationsChanged event,
    Emitter<NotificationsState> emit,
  ) async {
    final previousPreferences = state.preferences ?? _defaultPreferences();
    final nextPreferences = _copyWithNotification(
      previousPreferences,
      event.type,
      event.enabled,
    );

    emit(
      state.copyWith(
        preferences: nextPreferences,
        updatingType: event.type,
        status: const StateStatus.loading(),
      ),
    );

    final result = await _setUserNotificationsUseCase(
      SetUserNotificationsUseCaseParams(
        pushNotificationsEnabled:
            event.type == UserPreferencesNotificationType.push
            ? event.enabled
            : null,
        emailNotificationsEnabled:
            event.type == UserPreferencesNotificationType.email
            ? event.enabled
            : null,
        marketingNotificationsEnabled:
            event.type == UserPreferencesNotificationType.marketing
            ? event.enabled
            : null,
      ),
    );

    result.fold(
      (Failure failure) {
        emit(
          state.copyWith(
            preferences: previousPreferences,
            updatingType: null,
            status: StateStatus.error(failure),
          ),
        );
      },
      (preferences) {
        emit(
          state.copyWith(
            preferences: preferences,
            updatingType: null,
            status: const StateStatus.success(),
          ),
        );
      },
    );
  }

  UserPreferences _copyWithNotification(
    UserPreferences preferences,
    UserPreferencesNotificationType type,
    bool enabled,
  ) {
    return switch (type) {
      UserPreferencesNotificationType.push => preferences.copyWith(
        pushNotificationsEnabled: enabled,
      ),
      UserPreferencesNotificationType.email => preferences.copyWith(
        emailNotificationsEnabled: enabled,
      ),
      UserPreferencesNotificationType.marketing => preferences.copyWith(
        marketingNotificationsEnabled: enabled,
      ),
    };
  }

  UserPreferences _defaultPreferences() {
    final now = DateTime.now();
    return UserPreferences(
      userId: '',
      language: UserLanguage.en,
      theme: UserTheme.system,
      pushNotificationsEnabled: true,
      emailNotificationsEnabled: true,
      marketingNotificationsEnabled: false,
      createdAt: now,
      updatedAt: now,
    );
  }
}
