import 'package:core/core.dart';
import 'package:injectable/injectable.dart';

@InjectableInit.microPackage(
  ignoreUnregisteredTypes: [ApiClient, TokenStorage, DeviceInfoService],
)
Future<void> configureAdminAuthDependencies() async {}
