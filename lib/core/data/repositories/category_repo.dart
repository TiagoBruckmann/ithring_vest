import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:ithring_vest/core/data/datasource/category_data_source.dart';
import 'package:ithring_vest/core/data/exceptions/exception.dart';
import 'package:ithring_vest/core/domain/entities/category_entity.dart';
import 'package:ithring_vest/core/domain/failures/failure.dart';
import 'package:ithring_vest/session.dart';

abstract class CategoryRepo {
  Future<Either<Failure, List<CategoryEntity>>> getDefaultCategories();
  Future<Either<Failure, List<CategoryEntity>>> getUserCategories( String documentId );
  Future<Either<Failure, void>> createUserCategory( Map<String, dynamic> json );
  Future<Either<Failure, void>> updateUserCategory( Map<String, dynamic> json );
}

@Injectable(as: CategoryRepo)
class CategoryRepoImpl implements CategoryRepo {
  final CategoryDataSource _dataSource;
  CategoryRepoImpl( this._dataSource );

  @override
  Future<Either<Failure, List<CategoryEntity>>> getDefaultCategories() async {
    try {
      final result = await _dataSource.getDefaultCategories();
      return right(result);
    } on ServerExceptions catch (e) {
      Session.crash.onError("getDefaultCategories_server_error", error: e.message);
      return left(ServerFailure(e.message));
    } catch (e) {
      Session.crash.onError("getDefaultCategories_error", error: e);
      return left(GeneralFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<CategoryEntity>>> getUserCategories( String documentId ) async {
    try {
      final result = await _dataSource.getUserCategories(documentId);
      return right(result);
    } on ServerExceptions catch (e) {
      Session.crash.onError("getUserCategories_server_error", error: e.message);
      return left(ServerFailure(e.message));
    } on UnauthorizedException catch (e) {
      Session.crash.onError("getUserCategories_unauthorized_error", error: e.message);
      return left(UnauthorizedFailure(e.message));
    } catch (e) {
      Session.crash.onError("getUserCategories_error", error: e);
      return left(GeneralFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> createUserCategory( Map<String, dynamic> json ) async {
    try {
      final result = await _dataSource.createUserCategory(json);
      return right(result);
    } on ServerExceptions catch (e) {
      Session.crash.onError("createUserCategory_server_error", error: e.message);
      return left(ServerFailure(e.message));
    } on UnauthorizedException catch (e) {
      Session.crash.onError("createUserCategory_unauthorized_error", error: e.message);
      return left(UnauthorizedFailure(e.message));
    } catch (e) {
      Session.crash.onError("createUserCategory_error", error: e);
      return left(GeneralFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateUserCategory( Map<String, dynamic> json ) async {
    try {
      final result = await _dataSource.updateUserCategory(json);
      return right(result);
    } on ServerExceptions catch (e) {
      Session.crash.onError("updateUserCategory_server_error", error: e.message);
      return left(ServerFailure(e.message));
    } on UnauthorizedException catch (e) {
      Session.crash.onError("updateUserCategory_unauthorized_error", error: e.message);
      return left(UnauthorizedFailure(e.message));
    } catch (e) {
      Session.crash.onError("updateUserCategory_error", error: e);
      return left(GeneralFailure(e.toString()));
    }
  }


}