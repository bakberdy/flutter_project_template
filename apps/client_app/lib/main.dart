import 'dart:async';

import 'package:app_log/app_log.dart';
import 'package:client_app/app.dart';
import 'package:client_app/di/configure_dependencies.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();

  AppLogConfig.init();
  Bloc.observer = const BlocLogObserver();

  unawaited(
    Analytics.track(const AnalyticsEvent(name: AnalyticsEventNames.appOpened)),
  );

  final config = AppConfig.instance;
  appLog('Client app started');
  appLog('ENVIRONMENT: ${config.environment}');
  appLog('API_URL: ${config.baseUrl}');

  runApp(App());
}
