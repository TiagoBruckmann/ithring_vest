import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:ithring_vest/core/data/datasource/type_account_data_source.dart';
import 'package:ithring_vest/core/data/exceptions/exception.dart';
import 'package:ithring_vest/core/domain/entities/type_account_entity.dart';
import 'package:ithring_vest/core/domain/failures/failure.dart';

abstract class TypeAccountRepo {
  Future<Either<Failure, List<TypeAccountEntity>>> getDefaultTypeAccount();
  Future<Either<Failure, List<TypeAccountEntity>>> getTypeAccounts();
}

@Injectable(as: TypeAccountRepo)
class TypeAccountRepoImpl implements TypeAccountRepo {
  final TypeAccountDataSource _dataSource;
  TypeAccountRepoImpl(this._dataSource);

  @override
  Future<Either<Failure, List<TypeAccountEntity>>> getDefaultTypeAccount() async {
    try {
      final result = await _dataSource.getDefaultTypeAccount();
      return right(result);
    } on ServerExceptions catch (e) {
      return left(ServerFailure(e.message));
    } catch (e) {
      return left(GeneralFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<TypeAccountEntity>>> getTypeAccounts() async {
    try {
      final result = await _dataSource.getTypeAccounts();
      return right(result);
    } on ServerExceptions catch (e) {
      return left(ServerFailure(e.message));
    } catch (e) {
      return left(GeneralFailure(e.toString()));
    }
  }

}