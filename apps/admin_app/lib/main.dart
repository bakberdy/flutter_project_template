import 'dart:async';

import 'package:admin_app/app.dart';
import 'package:admin_app/di/configure_dependencies.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();

  unawaited(
    Analytics.track(const AnalyticsEvent(name: AnalyticsEventNames.appOpened)),
  );

  runApp(App());
}
