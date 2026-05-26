import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:ithring_vest/core/data/repositories/coin_repo.dart';
import 'package:ithring_vest/core/domain/entities/coin_entity.dart';
import 'package:ithring_vest/core/domain/failures/failure.dart';

@injectable
class CoinUseCase {
  final CoinRepo _repo;
  CoinUseCase(this._repo);

  Future<Either<Failure, List<CoinEntity>>> getCoins() async {
    return await _repo.getCoins();
  }

}