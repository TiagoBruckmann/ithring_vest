import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:ithring_vest/core/data/datasource/coin_data_source.dart';
import 'package:ithring_vest/core/data/exceptions/exception.dart';
import 'package:ithring_vest/core/domain/entities/coin_entity.dart';
import 'package:ithring_vest/core/domain/failures/failure.dart';
import 'package:ithring_vest/session.dart';

abstract class CoinRepo {
  Future<Either<Failure, List<CoinEntity>>> getCoins();
}

@Injectable(as: CoinRepo)
class CoinRepoImpl implements CoinRepo {
  final CoinDataSource _dataSource;
  CoinRepoImpl(this._dataSource);

  @override
  Future<Either<Failure, List<CoinEntity>>> getCoins() async {
    try {
      final result = await _dataSource.getCoins();
      return right(result);
    } on ServerExceptions catch (e) {
      Session.crash.onError("getCoins_server_error", error: e.message);
      return left(ServerFailure(e.message));
    } catch (e) {
      Session.crash.onError("getCoins_error", error: e);
      return left(GeneralFailure(e.toString()));
    }
  }
}