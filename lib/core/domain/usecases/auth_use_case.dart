import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:ithring_vest/core/data/repositories/auth_repo.dart';
import 'package:ithring_vest/core/domain/entities/user_entity.dart';
import 'package:ithring_vest/core/domain/failures/failure.dart';

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

  Future<Either<Failure, UserEntity>> loginWithEmail( String email, String password ) async {
    final Map<String, String> params = {
      "email": email,
      "password": password,
    };

    return await _repo.loginWithEmail(params);
  }

  Future<Either<Failure, UserEntity>> google() async {
    return await _repo.google();
  }

  Future<Either<Failure, void>> forgotPassword( String email ) async {
    return await _repo.forgotPassword(email);
  }

}