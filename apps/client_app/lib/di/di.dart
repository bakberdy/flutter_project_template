import 'package:client_auth/client_auth.dart';
import 'package:core/di/injection.module.dart';
import 'package:injectable/injectable.dart';

@InjectableInit(
  externalPackageModulesBefore: [
    ExternalModule(CorePackageModule),
    ExternalModule(ClientAuthPackageModule),
  ],
)
Future<void> configureDependencies() async {}
