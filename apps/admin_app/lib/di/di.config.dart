// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:admin_auth/admin_auth.dart' as _i243;
import 'package:admin_preferences/admin_preferences.dart' as _i107;
import 'package:admin_profile/admin_profile.dart' as _i125;
import 'package:admin_users/admin_users.dart' as _i736;
import 'package:core/core.dart' as _i494;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    await _i494.CorePackageModule().init(gh);
    await _i243.AdminAuthPackageModule().init(gh);
    await _i125.AdminProfilePackageModule().init(gh);
    await _i107.AdminPreferencesPackageModule().init(gh);
    await _i736.AdminUsersPackageModule().init(gh);
    return this;
  }
}
