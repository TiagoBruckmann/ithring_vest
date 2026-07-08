import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:ithring_vest/core/data/exceptions/exception.dart';
import 'package:ithring_vest/core/data/model/card_model.dart';
import 'package:ithring_vest/core/domain/enums/step_missing_enum.dart';
import 'package:ithring_vest/session.dart';

abstract class CardDataSource {
  Future<List<CardModel>> getCards();
  Future<void> createCard( CardModel card );
  Future<void> updateCard( Map<String, dynamic> card );
}

@Injectable(as: CardDataSource)
class CardDataSourceImpl extends CardDataSource {
  final FirebaseFirestore db;
  final FirebaseAuth auth;
  CardDataSourceImpl( this.db, this.auth );

  @override
  Future<List<CardModel>> getCards() async {
    try {
      final userId = _validateUser();

      final snapshot = await db.collection("cards").doc(userId).collection(userId).get();
      return snapshot.docs
        .map((doc) => CardModel.fromJson(doc.data()))
        .toList()
        ..sort((a, b) => _getCardsPriority(a).compareTo(_getCardsPriority(b)));

    } on UnauthorizedException {
      rethrow;
    } on FirebaseException catch (e, st) {
      Session.crash.onError("getCards_FirebaseException", error: e, stackTrace: st);
      throw ServerExceptions(e.message ?? e.toString());
    } catch (e, st) {
      Session.crash.onError("getCards_error", error: e, stackTrace: st);
      throw GeneralException(e.toString());
    }
  }

  @override
  Future<void> createCard( CardModel card ) async {
    try {
      final userId = _validateUser();

      final WriteBatch batch = db.batch();
      final DocumentReference docRef = db.collection("cards").doc(userId).collection(userId).doc(card.id);
      batch.set(docRef, card.toJson());
      await batch.commit();

      if ( Session.user.stepMissing.trim() == StepMissingEnum.creditCard.name ) {
        db.collection("users").doc(userId).update(Session.user.updStatusRegisterJson());
      }

    } on UnauthorizedException {
      rethrow;
    } on FirebaseException catch (e, st) {
      Session.crash.onError("createCard_FirebaseException", error: e, stackTrace: st);
      throw ServerExceptions(e.message ?? e.toString());
    } catch (e, st) {
      Session.crash.onError("createCard_error", error: e, stackTrace: st);
      throw GeneralException(e.toString());
    }
  }

  @override
  Future<void> updateCard( Map<String, dynamic> card ) async {
    try {
      final userId = _validateUser();

      final WriteBatch batch = db.batch();
      final DocumentReference docRef = db.collection("cards").doc(userId).collection(userId).doc(card["id"]);
      batch.update(docRef, card);
      await batch.commit();

    } on UnauthorizedException {
      rethrow;
    } on FirebaseException catch (e, st) {
      Session.crash.onError("updateCard_FirebaseException", error: e, stackTrace: st);
      throw ServerExceptions(e.message ?? e.toString());
    } catch (e, st) {
      Session.crash.onError("updateCard_error", error: e, stackTrace: st);
      throw GeneralException(e.toString());
    }
  }

  String _validateUser() {
    final user = auth.currentUser;
    if ( user == null ) {
      const errorMessage = "User unauthorized to Cards";
      Session.crash.onError("CardDataSource _validateUser", error: errorMessage);
      throw UnauthorizedException(errorMessage);
    }

    return user.uid;
  }

  int _getCardsPriority( CardModel card ) {
    if ( card.isActive ) return 0; // 1º
    return 1; // 2º
  }

}