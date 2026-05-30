import 'package:injectable/injectable.dart';
import 'package:ithring_vest/core/data/repositories/category_repo.dart';
import 'package:ithring_vest/core/domain/entities/category_entity.dart';
import 'package:ithring_vest/core/domain/failures/failure.dart';
import 'package:dartz/dartz.dart';

@injectable
class CategoryUseCase {
  final CategoryRepo _repo;
  CategoryUseCase( this._repo );

  Future<Either<Failure, List<CategoryEntity>>> getDefaultCategories() async {
    return await _repo.getDefaultCategories();
  }

  Future<Either<Failure, List<CategoryEntity>>> getUserCategories() async {
    return await _repo.getUserCategories();
  }

  Future<Either<Failure, List<CategoryEntity>>> createUserCategories( List<CategoryEntity> categories ) async {
    return await _repo.createUserCategories(categories);
  }

  Future<Either<Failure, void>> createUserCategory( CategoryEntity category ) async {
    return await _repo.createUserCategory(category.toJson());
  }

  Future<Either<Failure, void>> updateUserCategory( CategoryEntity category ) async {
    return await _repo.createUserCategory(category.toJson());
  }

}