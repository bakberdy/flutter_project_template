import 'package:bloc/bloc.dart';
import 'package:core/config/core_app_config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:talker_bloc_logger/talker_bloc_logger_observer.dart';

final sl = GetIt.instance;

@InjectableInit.microPackage(ignoreUnregisteredTypes: [CoreAppConfig])
Future<void> configureCoreDependencies() async {
  Bloc.observer = sl<TalkerBlocObserver>();
}
