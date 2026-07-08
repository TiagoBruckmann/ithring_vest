import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:ithring_vest/core/data/datasource/card_data_source.dart';
import 'package:ithring_vest/core/data/exceptions/exception.dart';
import 'package:ithring_vest/core/data/model/card_model.dart';
import 'package:ithring_vest/core/domain/entities/card_entity.dart';
import 'package:ithring_vest/core/domain/failures/failure.dart';

abstract class CardRepo {
  Future<Either<Failure, List<CardEntity>>> getCards();
  Future<Either<Failure, CardEntity>> createCard( CardEntity card );
  Future<Either<Failure, void>> updateCard( Map<String, dynamic> card );
}

@Injectable(as: CardRepo)
class CardRepoImpl extends CardRepo {
  final CardDataSource _dataSource;
  CardRepoImpl( this._dataSource );

  @override
  Future<Either<Failure, List<CardEntity>>> getCards() async {
    try {
      final result = await _dataSource.getCards();
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
  Future<Either<Failure, CardEntity>> createCard( CardEntity card ) async {
    try {
      final cardModel = CardModel.fromEntity(card);
      await _dataSource.createCard(cardModel);
      return right(cardModel);
    } on UnauthorizedException catch (e) {
      return left(UnauthorizedFailure(e.message));
    } on ServerExceptions catch (e) {
      return left(ServerFailure(e.message));
    } catch (e) {
      return left(GeneralFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateCard( Map<String, dynamic> card ) async {
    try {
      final result = await _dataSource.updateCard(card);
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