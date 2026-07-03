import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:talker_bloc_logger/talker_bloc_logger_observer.dart';

final sl = GetIt.instance;

@InjectableInit.microPackage()
Future<void> configureCoreDependencies() async {
  Bloc.observer = sl<TalkerBlocObserver>();
}
