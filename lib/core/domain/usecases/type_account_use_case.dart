import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:ithring_vest/core/data/repositories/type_account_repo.dart';
import 'package:ithring_vest/core/domain/entities/type_account_entity.dart';
import 'package:ithring_vest/core/domain/failures/failure.dart';

@injectable
class TypeAccountUseCase {
  final TypeAccountRepo _repo;
  TypeAccountUseCase(this._repo);

  Future<Either<Failure, List<TypeAccountEntity>>> getDefaultTypeAccount() async {
    return await _repo.getDefaultTypeAccount();
  }

  Future<Either<Failure, List<TypeAccountEntity>>> getTypeAccounts() async {
    return await _repo.getTypeAccounts();
  }

}