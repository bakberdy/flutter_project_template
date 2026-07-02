library;

export 'package:talker/talker.dart';

export 'config/app_config.dart';
export 'config/core_app_config.dart';
export 'api/api.dart';
export 'bloc/field_state/field_state.dart';
export 'bloc/core_navigation/core_navigation_bloc.dart';
export 'bloc/state_status/state_status.dart';
export 'shared/shared.dart';
export 'monitoring/analytics/analytics.dart';
export 'monitoring/analytics/analytics_events.dart';
export 'monitoring/analytics/providers/talker_analytics_provider.dart';
export 'monitoring/crashlytics/crashlytics.dart';
export 'monitoring/crashlytics/crashlytics_provider.dart';
export 'monitoring/crashlytics/providers/talker_crash_provider.dart';
export 'storage/local/local_storage.dart';
export 'storage/local/shared_preferences_storage.dart';
export 'usecases/use_case.dart';
export 'utils/typedef.dart';
export 'di/injection.dart' show configureCoreDependencies, sl;
export 'di/di_context_x.dart';
