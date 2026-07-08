import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:ithring_vest/core/data/datasource/user_data_source.dart';
import 'package:ithring_vest/core/data/exceptions/exception.dart';
import 'package:ithring_vest/core/domain/failures/failure.dart';

abstract class UserRepo {
  Future<Either<Failure, void>> updateUser( Map<String, dynamic> json );
}

@Injectable(as: UserRepo)
class UserRepoImpl implements UserRepo {
  final UserDataSource _dataSource;
  UserRepoImpl(this._dataSource);

  @override
  Future<Either<Failure, void>> updateUser( Map<String, dynamic> json ) async {
    try {
      final result = await _dataSource.updateUser(json);
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