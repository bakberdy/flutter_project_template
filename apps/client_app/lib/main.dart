import 'dart:async';

import 'package:client_app/app/app.dart';
import 'package:client_app/di/di.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppConfig.load();
  await configureDependencies();

  unawaited(
    Analytics.track(const AnalyticsEvent(name: AnalyticsEventNames.appOpened)),
  );
  runApp(App());
}
