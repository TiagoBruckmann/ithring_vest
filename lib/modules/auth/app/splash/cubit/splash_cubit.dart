import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:equatable/equatable.dart';
import 'package:ithring_vest/core/domain/source/local/injection/injection.dart';
import 'package:ithring_vest/core/domain/source/local/mobx/user/user_mobx.dart';
import 'package:ithring_vest/core/domain/usecases/auth_use_case.dart';
import 'package:ithring_vest/modules/auth/routes/auth_path.dart';
import 'package:ithring_vest/modules/dashboard/routes/dash_path.dart';
import 'package:ithring_vest/session.dart';

part 'splash_cubit_state.dart';

@injectable
class SplashCubit extends Cubit<SplashCubitState> {
  final AuthUseCase _authUseCase;
  SplashCubit(
    this._authUseCase,
  ) : super(const SplashInitialState()) {
    _init();
  }

  Future<void> _init() async {
    final response = await _authUseCase.verifyConnection();
    response.fold(
      (failure) => _goToPresentation(),
      (user) {

        final userMobx = getIt<UserMobx>();
        userMobx.setUser(user);

        if ( user.isRegisterFinished ) {
          return Session.navigation.go(DashPath().dashboard);
        }

        return Session.navigation.go(AuthPath.registerPath.register);

      },
    );
  }

  void _goToPresentation() {
    Session.navigation.go(AuthPath.loginPath.presentation);
  }

}