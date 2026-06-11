import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:ithring_vest/core/data/repositories/auth_repo.dart';
import 'package:ithring_vest/core/domain/entities/user_entity.dart';
import 'package:ithring_vest/core/domain/failures/failure.dart';
import 'package:ithring_vest/session.dart';

@injectable
class AuthUseCase {
  final AuthRepo _repo;
  AuthUseCase( this._repo );

  Future<Either<Failure, UserEntity>> verifyConnection() async {
    return await _repo.verifyConnection();
  }

  Future<Either<Failure, UserEntity>> registerUserWithEmail( UserEntity user, String password ) async {
    return await _repo.registerUserWithEmail(user, password);
  }

  Future<Either<Failure, UserEntity>> loginWithEmail( String email, String password, bool isRememberMe ) async {
    Session.localStorage.saveRememberLogin(isRememberMe);
    if ( isRememberMe ) {
      Session.localStorage.saveLoginEmail(email);
      Session.localStorage.saveLoginPassword(password);
    }

    return await _repo.loginWithEmail(email, password);
  }

  Future<Either<Failure, UserEntity>> google() async {
    return await _repo.google();
  }

  Future<Either<Failure, void>> forgotPassword( String email ) async {
    return await _repo.forgotPassword(email);
  }

}