import 'package:core/config/core_app_config.dart';
import 'package:core/monitoring/initialize_core_monitoring.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:talker/talker.dart';

final sl = GetIt.instance;

@InjectableInit.microPackage(ignoreUnregisteredTypes: [CoreAppConfig])
Future<void> configureCoreDependencies() async {
  initializeCoreMonitoring(sl<Talker>());
}
