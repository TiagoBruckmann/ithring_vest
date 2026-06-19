import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:ithring_vest/core/data/repositories/account_repo.dart';
import 'package:ithring_vest/core/domain/entities/account_entity.dart';
import 'package:ithring_vest/core/domain/failures/failure.dart';

@injectable
class AccountUseCase {
  final AccountRepo _repo;
  AccountUseCase( this._repo );

  Future<Either<Failure, List<AccountEntity>>> getUserAccounts({ bool isBlockedFilter = false }) async {
    return await _repo.getUserAccounts(isBlockedFilter);
  }

  Future<Either<Failure, AccountEntity>> createUserAccount( AccountEntity account ) async {
    return await _repo.createUserAccount(account);
  }

  Future<Either<Failure, void>> updateUserAccount( Map<String, dynamic> json ) async {
    return await _repo.updateUserAccount(json);
  }

}