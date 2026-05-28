import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:ithring_vest/core/data/exceptions/exception.dart';
import 'package:ithring_vest/core/data/model/user_model.dart';
import 'package:ithring_vest/session.dart';

abstract class AuthDataSource {
  Future<UserModel> verifyConnection();
  Future<UserModel> registerUserWithEmail( UserModel user, String password );
  Future<UserModel> loginWithEmail( Map<String, dynamic> params );
  Future<UserModel> google();
  Future<void> forgotPassword( String email );
}

@Injectable(as: AuthDataSource)
class AuthDataSourceImpl implements AuthDataSource {
  final FirebaseFirestore db;
  final FirebaseAuth auth;
  AuthDataSourceImpl( this.db, this.auth);

  @override
  Future<UserModel> verifyConnection() async {
    try {
      User? user = auth.currentUser;
      if ( user == null ) {
        String message = "Usuário não autenticado ou sem conta";
        Session.crash.onError("UserUnauthorized => ", error: message);
        throw UnauthorizedException(message);
      }

      final response = await db.collection("users").doc(user.uid).get();
      if ( !response.exists ) {
        String message = "Não foi possível encontrar o usuário";
        Session.crash.onError("UserNotFound => ", error: message);
        throw UnauthorizedException(message);
      }

      return UserModel.fromJson(response.data()!);
    } catch (e) {
      Session.crash.onError("VerifyConnectionError => ", error: e.toString());
      throw GeneralException(e.toString());
    }
  }

  @override
  Future<UserModel> registerUserWithEmail( UserModel user, String password ) async {
    UserCredential? firebaseUserCredential;

    try {
      firebaseUserCredential = await auth.createUserWithEmailAndPassword(
        email: user.email,
        password: password,
      );

      final firebaseUser = firebaseUserCredential.user;
      if ( firebaseUser == null ) {
        Session.crash.onError("registerUserWithEmail", error: "Falha ao criar usuário: ${user.email}");
        throw ServerExceptions("toast.error.user_register_failed");
      }

      user = user.setRegisterData(firebaseUser.uid);

      await Future.wait([
        firebaseUser.updateProfile(displayName: user.name, photoURL: user.photoUrl),
        db.collection("users").doc(user.id).set(user.registerUserToJson(user.id)),
      ]);

      return user;
    } on FirebaseAuthException catch (e, st) {
      throw _mapAuthException(e, st);
    } catch (e, st) {
      Session.crash.onError("registerUserWithEmail_catch", error: e, stackTrace: st);
      throw GeneralException("toast.error.user_register_failed");
    }
  }

  @override
  Future<UserModel> loginWithEmail(Map<String, dynamic> params) {
    // TODO: implement loginWithEmail
    throw UnimplementedError();
  }

  @override
  Future<UserModel> google() {
    // TODO: implement google
    throw UnimplementedError();
  }

  @override
  Future<void> forgotPassword(String email) {
    // TODO: implement forgotPassword
    throw UnimplementedError();
  }

  Exception _mapAuthException( FirebaseAuthException e, StackTrace st ) {
    Session.crash.onError("_mapAuthException code: ${e.code}", error: e, stackTrace: st);

    switch (e.code) {
      case "weak-password":
        return WeekPasswordException("validations.invalid.password");
      case "email-already-in-use":
        return EmailUsedException("validations.invalid.email_already_in_use");
      case "invalid-email":
        return InvalidEmailException("validations.invalid.email");
      default:
        return ServerExceptions(e.message ?? e.code);
    }
  }

}