import 'package:bloc/bloc.dart';
import 'package:core/monitoring/analytics/analytics.dart';
import 'package:core/monitoring/analytics/providers/talker_analytics_provider.dart';
import 'package:core/monitoring/crashlytics/crashlytics.dart';
import 'package:core/monitoring/crashlytics/providers/talker_crash_provider.dart';
import 'package:talker/talker.dart';
import 'package:talker_bloc_logger/talker_bloc_logger_observer.dart';

void initializeCoreMonitoring(Talker talker) {
  Analytics.initialize([TalkerAnalyticsProvider(talker)]);
  Crashlytics.initialize([TalkerCrashProvider(talker)]);
  Bloc.observer = TalkerBlocObserver(talker: talker);
}
