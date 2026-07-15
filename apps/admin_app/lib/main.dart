import 'dart:async';

import 'package:admin_app/app/app.dart';
import 'package:admin_app/di/di.dart';
import 'package:admin_app/src/common/config/app_config.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

Future<void> main() => AppErrorHandler.run(() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppConfig.load();
  await configureDependencies();
  initializeCoreMonitoring(
    sl<Talker>(),
    enableAnalytics: AppConfig.instance.enableAnalytics,
    enableCrashlytics: AppConfig.instance.enableCrashlytics,
  );

  unawaited(
    Analytics.track(const AnalyticsEvent(name: AnalyticsEventNames.appOpened)),
  );
  runApp(const App());
});
