import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:ithring_vest/core/data/repositories/card_repo.dart';
import 'package:ithring_vest/core/domain/entities/card_entity.dart';
import 'package:ithring_vest/core/domain/failures/failure.dart';

@injectable
class CardUseCase {
  final CardRepo _repo;
  CardUseCase( this._repo );

  Future<Either<Failure, List<CardEntity>>> getCards() async {
    return await _repo.getCards();
  }

  Future<Either<Failure, CardEntity>> createCard( CardEntity card ) async {
    return await _repo.createCard(card);
  }

  Future<Either<Failure, void>> updateCard( CardEntity card ) async {
    return await _repo.updateCard(card.updateAmountJson());
  }

}