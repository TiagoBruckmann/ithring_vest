import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:ithring_vest/core/data/exceptions/exception.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ithring_vest/session.dart';

abstract class UserDataSource {
  Future<void> updateUser( Map<String, dynamic> json );
}

@Injectable(as : UserDataSource)
class UserDataSourceImpl implements UserDataSource {
  final FirebaseFirestore db;
  final FirebaseAuth auth;
  UserDataSourceImpl( this.db, this.auth );

  @override
  Future<void> updateUser( Map<String, dynamic> json ) async {
    try {
      final userId = _validateUser();
      db.collection("users").doc(userId).update(json);
    } on UnauthorizedException {
      rethrow;
    } on FirebaseException catch (e, st) {
      Session.crash.onError("updateUser_FirebaseException", error: e, stackTrace: st);
      throw ServerExceptions(e.message ?? e.toString());
    } catch (e, st) {
      Session.crash.onError("updateUser_error", error: e, stackTrace: st);
      throw GeneralException(e.toString());
    }
  }

  String _validateUser() {
    final user = auth.currentUser;
    if ( user == null ) {
      const errorMessage = "User unauthorized to User";
      Session.crash.onError("CategoryDataSource _validateUser", error: errorMessage);
      throw UnauthorizedException(errorMessage);
    }

    return user.uid;
  }

}