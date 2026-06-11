// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i974;
import 'package:firebase_auth/firebase_auth.dart' as _i59;
import 'package:get_it/get_it.dart' as _i174;
import 'package:http/http.dart' as _i519;
import 'package:injectable/injectable.dart' as _i526;
import 'package:ithring_vest/core/data/datasource/auth_data_source.dart'
    as _i975;
import 'package:ithring_vest/core/data/datasource/category_data_source.dart'
    as _i830;
import 'package:ithring_vest/core/data/datasource/coin_data_source.dart'
    as _i363;
import 'package:ithring_vest/core/data/repositories/auth_repo.dart' as _i471;
import 'package:ithring_vest/core/data/repositories/category_repo.dart'
    as _i476;
import 'package:ithring_vest/core/data/repositories/coin_repo.dart' as _i812;
import 'package:ithring_vest/core/domain/source/local/injection/module/external_module.dart'
    as _i399;
import 'package:ithring_vest/core/domain/source/local/mobx/connection/connection_mobx.dart'
    as _i311;
import 'package:ithring_vest/core/domain/source/local/mobx/user/user_mobx.dart'
    as _i477;
import 'package:ithring_vest/core/domain/usecases/auth_use_case.dart' as _i618;
import 'package:ithring_vest/core/domain/usecases/category_use_case.dart'
    as _i999;
import 'package:ithring_vest/core/domain/usecases/coin_use_case.dart' as _i912;
import 'package:ithring_vest/modules/auth/app/login/cubit/login_cubit.dart'
    as _i1023;
import 'package:ithring_vest/modules/auth/app/register/cubit/register_cubit.dart'
    as _i706;
import 'package:ithring_vest/modules/auth/app/splash/cubit/splash_cubit.dart'
    as _i814;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final externalModule = _$ExternalModule();
    gh.singleton<_i311.ConnectionMobx>(() => _i311.ConnectionMobx());
    gh.lazySingleton<_i974.FirebaseFirestore>(() => externalModule.firestore);
    gh.lazySingleton<_i59.FirebaseAuth>(() => externalModule.firebaseAuth);
    gh.lazySingleton<_i519.Client>(() => externalModule.httpClient);
    gh.lazySingleton<_i477.UserMobx>(() => _i477.UserMobx());
    gh.factory<_i975.AuthDataSource>(() => _i975.AuthDataSourceImpl(
          gh<_i974.FirebaseFirestore>(),
          gh<_i59.FirebaseAuth>(),
        ));
    gh.factory<_i830.CategoryDataSource>(() => _i830.CategoryDataSourceImpl(
          gh<_i974.FirebaseFirestore>(),
          gh<_i59.FirebaseAuth>(),
        ));
    gh.factory<_i471.AuthRepo>(
        () => _i471.AuthRepoImpl(gh<_i975.AuthDataSource>()));
    gh.factory<_i363.CoinDataSource>(
        () => _i363.CoinDataSourceImpl(gh<_i974.FirebaseFirestore>()));
    gh.factory<_i812.CoinRepo>(
        () => _i812.CoinRepoImpl(gh<_i363.CoinDataSource>()));
    gh.factory<_i618.AuthUseCase>(
        () => _i618.AuthUseCase(gh<_i471.AuthRepo>()));
    gh.factory<_i476.CategoryRepo>(
        () => _i476.CategoryRepoImpl(gh<_i830.CategoryDataSource>()));
    gh.factory<_i999.CategoryUseCase>(
        () => _i999.CategoryUseCase(gh<_i476.CategoryRepo>()));
    gh.factory<_i1023.LoginCubit>(
        () => _i1023.LoginCubit(gh<_i618.AuthUseCase>()));
    gh.factory<_i814.SplashCubit>(
        () => _i814.SplashCubit(gh<_i618.AuthUseCase>()));
    gh.factory<_i912.CoinUseCase>(
        () => _i912.CoinUseCase(gh<_i812.CoinRepo>()));
    gh.factory<_i706.RegisterCubit>(() => _i706.RegisterCubit(
          gh<_i999.CategoryUseCase>(),
          gh<_i618.AuthUseCase>(),
          gh<_i912.CoinUseCase>(),
        ));
    return this;
  }
}

class _$ExternalModule extends _i399.ExternalModule {}
