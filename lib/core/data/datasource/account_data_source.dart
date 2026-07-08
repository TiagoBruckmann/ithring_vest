import 'package:injectable/injectable.dart';
import 'package:ithring_vest/core/data/exceptions/exception.dart';
import 'package:ithring_vest/core/data/model/account_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ithring_vest/core/domain/enums/step_missing_enum.dart';
import 'package:ithring_vest/session.dart';

abstract class AccountDataSource {
  Future<List<AccountModel>> getUserAccounts( bool isBlockedFilter );
  Future<void> createUserAccount( AccountModel model );
  Future<void> updateUserAccount( Map<String, dynamic> json );
}

@Injectable(as: AccountDataSource)
class AccountDataSourceImpl implements AccountDataSource {
  final FirebaseFirestore db;
  final FirebaseAuth auth;
  AccountDataSourceImpl( this.db, this.auth );

  @override
  Future<List<AccountModel>> getUserAccounts( bool isBlockedFilter ) async {
    try {
      final userId = _validateUser();

      final snapshot = await db.collection("accounts")
        .where("user_id", isEqualTo: userId)
        .where("is_blocked", isEqualTo: isBlockedFilter)
        .get();

      final list = snapshot.docs
          .map((doc) => AccountModel.fromJson(doc.data()))
          .toList();

      List<AccountModel> tempList = List.from(list);
      tempList.retainWhere((account) => account.father.trim().isNotEmpty);

      for ( final account in tempList ) {
        final fatherAccountId = list.indexWhere((element) => element.id.trim() == account.father.trim());

        if ( !fatherAccountId.isNegative ) {
          final fatherAccount = list[fatherAccountId];
          list.removeAt(fatherAccountId);
          fatherAccount.children.add(account);
          list.insert(fatherAccountId, fatherAccount);
          list.removeWhere((element) => element.id.trim() == account.id.trim());
        }

      }
      tempList.clear();

      return list..sort((a, b) => a.amount.compareTo(b.amount));

    } on UnauthorizedException {
      rethrow;
    } on FirebaseException catch (e, st) {
      Session.crash.onError("getUserCategories_FirebaseException", error: e, stackTrace: st);
      throw ServerExceptions(e.message ?? e.toString());
    } catch (e, st) {
      Session.crash.onError("getUserCategories_error", error: e, stackTrace: st);
      throw GeneralException(e.toString());
    }
  }

  @override
  Future<void> createUserAccount( AccountModel model ) async {
    try {
      final userId = _validateUser();

      final WriteBatch batch = db.batch();
      final DocumentReference docRef = db.collection("accounts").doc(model.id);
      batch.set(docRef, model.toJson());
      await batch.commit();

      if ( Session.user.stepMissing.trim() == StepMissingEnum.accounts.name ) {
        db.collection("users").doc(userId).update(Session.user.updStatusRegisterJson());
      }

    } on UnauthorizedException {
      rethrow;
    } on FirebaseException catch (e, st) {
      Session.crash.onError("createUserAccount_FirebaseException", error: e, stackTrace: st);
      throw ServerExceptions(e.message ?? e.toString());
    } catch (e, st) {
      Session.crash.onError("createUserAccount_error", error: e, stackTrace: st);
      throw GeneralException(e.toString());
    }
  }

  @override
  Future<void> updateUserAccount( Map<String, dynamic> json ) async {
    try {
      _validateUser();
      final WriteBatch batch = db.batch();
      final DocumentReference docRef = db.collection("accounts").doc(json["id"]);
      batch.update(docRef, json);
      await batch.commit();

    } on UnauthorizedException {
      rethrow;
    } on FirebaseException catch (e, st) {
      Session.crash.onError("updateUserAccount_FirebaseException", error: e, stackTrace: st);
      throw ServerExceptions(e.message ?? e.toString());
    } catch (e, st) {
      Session.crash.onError("updateUserAccount_error", error: e, stackTrace: st);
      throw GeneralException(e.toString());
    }
  }

  String _validateUser() {
    final user = auth.currentUser;
    if ( user == null ) {
      const errorMessage = "User unauthorized to Accounts";
      Session.crash.onError("AccountDataSource _validateUser", error: errorMessage);
      throw UnauthorizedException(errorMessage);
    }

    return user.uid;
  }

}