import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'injection.module.dart';

final sl = GetIt.instance;

@InjectableInit.microPackage()
Future<void> configureCoreDependencies() async =>
    CorePackageModule().init(GetItHelper(GetIt.instance));
