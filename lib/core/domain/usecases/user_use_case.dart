import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:ithring_vest/core/data/repositories/user_repo.dart';
import 'package:ithring_vest/core/domain/entities/user_entity.dart';
import 'package:ithring_vest/core/domain/failures/failure.dart';

@injectable
class UserUseCase {
  final UserRepo _repo;
  UserUseCase( this._repo );

  Future<Either<Failure, void>> updateUser( UserEntity user ) async {
    return await _repo.updateUser(user.updStatusRegisterJson());
  }

}