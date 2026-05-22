// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:ithring_vest/core/domain/source/local/mobx/connection/connection_mobx.dart'
    as _i311;
import 'package:ithring_vest/core/domain/source/local/mobx/user/user_mobx.dart'
    as _i477;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.singleton<_i311.ConnectionMobx>(() => _i311.ConnectionMobx());
    gh.lazySingleton<_i477.UserMobx>(() => _i477.UserMobx());
    return this;
  }
}
