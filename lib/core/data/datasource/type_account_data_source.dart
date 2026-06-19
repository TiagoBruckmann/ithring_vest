import 'package:injectable/injectable.dart';
import 'package:ithring_vest/core/data/exceptions/exception.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ithring_vest/core/data/model/type_account_model.dart';
import 'package:ithring_vest/session.dart';

abstract class TypeAccountDataSource {
  Future<List<TypeAccountModel>> getDefaultTypeAccount();
  Future<List<TypeAccountModel>> getTypeAccounts();
}

@Injectable(as : TypeAccountDataSource)
class TypeAccountDataSourceImpl implements TypeAccountDataSource {
  final FirebaseFirestore db;
  TypeAccountDataSourceImpl( this.db );

  @override
  Future<List<TypeAccountModel>> getDefaultTypeAccount() async {
    try {

      final snapshot = await db.collection("default_type_account").get();
      return snapshot.docs
          .map((doc) => TypeAccountModel.fromJson(doc.data()))
          .toList();

    } on FirebaseException catch (e, st) {
      Session.crash.onError("getDefaultTypeAccount_FirebaseException", error: e, stackTrace: st);
      throw ServerExceptions(e.message ?? e.toString());
    } catch (e, st) {
      Session.crash.onError("getDefaultTypeAccount_error", error: e, stackTrace: st);
      throw GeneralException(e.toString());
    }
  }

  @override
  Future<List<TypeAccountModel>> getTypeAccounts() async {
    try {

      final snapshot = await db.collection("type_accounts").get();
      return snapshot.docs
          .map((doc) => TypeAccountModel.fromJson(doc.data()))
          .toList();

    } on FirebaseException catch (e, st) {
      Session.crash.onError("getTypeAccounts_FirebaseException", error: e, stackTrace: st);
      throw ServerExceptions(e.message ?? e.toString());
    } catch (e, st) {
      Session.crash.onError("getTypeAccounts_error", error: e, stackTrace: st);
      throw GeneralException(e.toString());
    }
  }

}