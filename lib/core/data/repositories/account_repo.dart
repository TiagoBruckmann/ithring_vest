import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:ithring_vest/core/data/datasource/account_data_source.dart';
import 'package:ithring_vest/core/data/exceptions/exception.dart';
import 'package:ithring_vest/core/data/model/account_model.dart';
import 'package:ithring_vest/core/domain/entities/account_entity.dart';
import 'package:ithring_vest/core/domain/failures/failure.dart';

abstract class AccountRepo {
  Future<Either<Failure, List<AccountEntity>>> getUserAccounts( bool isBlockedFilter );
  Future<Either<Failure, AccountEntity>> createUserAccount( AccountEntity account );
  Future<Either<Failure, void>> updateUserAccount( Map<String, dynamic> json );
}

@Injectable(as: AccountRepo)
class AccountRepoImpl implements AccountRepo {
  final AccountDataSource _dataSource;
  AccountRepoImpl( this._dataSource );

  @override
  Future<Either<Failure, List<AccountEntity>>> getUserAccounts( bool isBlockedFilter ) async {
    try {
      final result = await _dataSource.getUserAccounts(isBlockedFilter);
      return right(result);
    } on UnauthorizedException catch (e) {
      return left(UnauthorizedFailure(e.message));
    } on ServerExceptions catch (e) {
      return left(ServerFailure(e.message));
    }  catch (e) {
      return left(GeneralFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, AccountEntity>> createUserAccount( AccountEntity account ) async {
    try {
      AccountModel accountModel = AccountModel.fromEntity(account);
      await _dataSource.createUserAccount(accountModel);
      return right(accountModel);
    } on UnauthorizedException catch (e) {
      return left(UnauthorizedFailure(e.message));
    } on ServerExceptions catch (e) {
      return left(ServerFailure(e.message));
    } catch (e) {
      return left(GeneralFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateUserAccount( Map<String, dynamic> json ) async {
    try {
      final result = await _dataSource.updateUserAccount(json);
      return right(result);
    } on UnauthorizedException catch (e) {
      return left(UnauthorizedFailure(e.message));
    } on ServerExceptions catch (e) {
      return left(ServerFailure(e.message));
    } catch (e) {
      return left(GeneralFailure(e.toString()));
    }
  }

}