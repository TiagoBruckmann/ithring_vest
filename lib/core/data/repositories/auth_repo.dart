import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:ithring_vest/core/data/datasource/auth_data_source.dart';
import 'package:ithring_vest/core/data/exceptions/exception.dart';
import 'package:ithring_vest/core/data/model/user_model.dart';
import 'package:ithring_vest/core/domain/entities/user_entity.dart';
import 'package:ithring_vest/core/domain/failures/failure.dart';

abstract class AuthRepo {
  bool verifyConnection();
  Future<Either<Failure, UserEntity>> registerUserWithEmail( UserEntity user, String password );
  Future<Either<Failure, UserEntity>> loginWithEmail( Map<String, dynamic> params );
  Future<Either<Failure, UserEntity>> google();
  Future<Either<Failure, void>> forgotPassword( String email );
}

@Injectable(as: AuthRepo)
class AuthRepoImpl implements AuthRepo {
  final AuthDataSource _dataSource;
  AuthRepoImpl( this._dataSource );

  @override
  bool verifyConnection() {
    return _dataSource.verifyConnection();
  }

  @override
  Future<Either<Failure, UserEntity>> registerUserWithEmail( UserEntity user, String password ) async {
    try {
      final result = await _dataSource.registerUserWithEmail(UserModel.fromEntity(user), password);
      return Right(result);
    }  on WeekPasswordException catch (e) {
      return left(WeekPasswordFailure(e.message));
    } on EmailUsedException catch (e) {
      return left(UsedEmailFailure(e.message));
    } on InvalidEmailException catch (e) {
      return left(InvalidEmailFailure(e.message));
    }  on ServerExceptions catch (e) {
      return left(ServerFailure(e.message));
    } catch (e) {
      return left(GeneralFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> loginWithEmail(Map<String, dynamic> params) {
    // TODO: implement loginWithEmail
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, UserEntity>> google() {
    // TODO: implement google
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> forgotPassword(String email) {
    // TODO: implement forgotPassword
    throw UnimplementedError();
  }

}