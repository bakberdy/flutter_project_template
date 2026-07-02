import 'package:admin_users/admin_users.dart';
import 'package:core/core.dart';

Future<void> configureDependencies() async {
  await configureCoreDependencies();
  configureAdminUsersDependencies();
}
