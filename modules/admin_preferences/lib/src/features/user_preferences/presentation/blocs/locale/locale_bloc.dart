import 'dart:async';
import 'dart:ui';

import 'package:admin_preferences/src/common/config/admin_preferences_constants.dart';
import 'package:admin_preferences/src/features/user_preferences/domain/entities/user_preferences.dart';
import 'package:admin_preferences/src/features/user_preferences/domain/usecases/get_user_language_use_case.dart';
import 'package:admin_preferences/src/features/user_preferences/domain/usecases/set_user_language_use_case.dart';
import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'locale_bloc.freezed.dart';
part 'locale_event.dart';
part 'locale_state.dart';

@Injectable()
class LocaleBloc extends Bloc<LocaleEvent, LocaleState> {
  final GetUserLanguageUseCase _getUserLanguageUseCase;
  final SetUserLanguageUseCase _setUserLanguageUseCase;
  static const List<Locale> _supportedLanguageCodes =
      AdminPreferencesConstants.supportedLocales;

  LocaleBloc(this._getUserLanguageUseCase, this._setUserLanguageUseCase)
    : super(const LocaleState()) {
    on<LocaleStarted>(_onStarted);
    on<LocaleChanged>(_onLocaleChanged);
  }

  void setLocale(String languageCode) {
    add(LocaleEvent.changed(languageCode));
  }

  Future<void> _onStarted(
    LocaleStarted event,
    Emitter<LocaleState> emit,
  ) async {
    emit(state.copyWith(status: const StateStatus.loading()));

    final result = await _getUserLanguageUseCase(const NoParams());

    await result.fold(
      (Failure failure) {
        emit(state.copyWith(status: StateStatus.error(failure)));
      },
      (language) async {
        if (language != null) {
          emit(
            state.copyWith(
              languageCode: language.languageCode,
              status: const StateStatus.success(),
            ),
          );
        } else {
          final deviceLanguage =
              UserLanguage.fromLanguageCode(event.deviceLanguageCode) ??
              UserLanguage.en;
          await _setUserLanguageUseCase(
            SetUserLanguageUseCaseParams(language: deviceLanguage),
          );
          if (emit.isDone) {
            return;
          }
          emit(
            state.copyWith(
              languageCode: deviceLanguage.languageCode,
              status: const StateStatus.success(),
            ),
          );
        }
      },
    );
  }

  Future<void> _onLocaleChanged(
    LocaleChanged event,
    Emitter<LocaleState> emit,
  ) async {
    if (!_supportedLanguageCodes.any(
      (locale) => locale.languageCode == event.languageCode,
    )) {
      return;
    }

    emit(
      state.copyWith(
        languageCode: event.languageCode,
        status: const StateStatus.loading(),
      ),
    );

    final language = UserLanguage.fromLanguageCode(event.languageCode);
    if (language == null) {
      return;
    }

    final result = await _setUserLanguageUseCase(
      SetUserLanguageUseCaseParams(language: language),
    );

    result.fold(
      (Failure failure) {
        emit(state.copyWith(status: StateStatus.error(failure)));
      },
      (_) {
        emit(state.copyWith(status: const StateStatus.success()));
      },
    );
  }
}
