import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:equatable/equatable.dart';
import 'package:ithring_vest/core/domain/source/local/injection/injection.dart';
import 'package:ithring_vest/core/domain/source/local/mobx/user/user_mobx.dart';
import 'package:ithring_vest/modules/auth/routes/auth_path.dart';
import 'package:ithring_vest/session.dart';

part 'splash_cubit_state.dart';

@injectable
class SplashCubit extends Cubit<SplashCubitState> {
  SplashCubit() : super(const SplashInitialState()) {
    _init();
  }

  Future<void> _init() async {
    final userMobx = getIt<UserMobx>();
    await Future.delayed(const Duration(seconds: 5));

    if ( userMobx.user.id.trim().isNotEmpty ) {

    }

    return Session.navigation.push(AuthPath.loginPath.presentation);
  }

}