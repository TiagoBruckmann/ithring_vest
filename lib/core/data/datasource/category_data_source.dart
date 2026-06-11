import 'package:injectable/injectable.dart';
import 'package:ithring_vest/core/data/exceptions/exception.dart';
import 'package:ithring_vest/core/data/model/category_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ithring_vest/core/domain/enums/step_missing_enum.dart';
import 'package:ithring_vest/session.dart';

abstract class CategoryDataSource {
  Future<List<CategoryModel>> getDefaultCategories();
  Future<List<CategoryModel>> getUserCategories();
  Future<void> createUserCategories( List<CategoryModel> categories );
  Future<void> createUserCategory( Map<String, dynamic> json );
  Future<void> updateUserCategories( List<CategoryModel> categories );
  Future<void> updateUserCategory( Map<String, dynamic> json );
}

@Injectable(as: CategoryDataSource)
class CategoryDataSourceImpl implements CategoryDataSource {
  final FirebaseFirestore db;
  final FirebaseAuth auth;
  CategoryDataSourceImpl( this.db, this.auth );

  @override
  Future<List<CategoryModel>> getDefaultCategories() async {
    try {
      final snapshot = await db.collection("default_categories").get();
      return snapshot.docs
          .map((doc) => CategoryModel.fromJson(doc.data()))
          .toList()
          ..sort((a, b) => _getCategoryPriority(a).compareTo(_getCategoryPriority(b)));

    } on FirebaseException catch (e, st) {
      Session.crash.onError("getDefaultCategories_FirebaseException", error: e, stackTrace: st);
      throw ServerExceptions(e.message ?? e.toString());
    } catch (e, st) {
      Session.crash.onError("getDefaultCategories_error", error: e, stackTrace: st);
      throw GeneralException(e.toString());
    }
  }

  @override
  Future<List<CategoryModel>> getUserCategories() async {
    try {
      final userId = _validateUser();

      final dateNow = DateTime.now();
      int year = dateNow.year;
      int month = dateNow.month;

      String date = "$year-${Session.utils.parseNumberLessThan10(month)}";

      final snapshot = await db.collection("categories").doc(date).collection(userId).get();
      return snapshot.docs
          .map((doc) => CategoryModel.fromJson(doc.data()))
          .toList()
          ..sort((a, b) => _getCategoryPriority(a).compareTo(_getCategoryPriority(b)));

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
  Future<void> createUserCategories( List<CategoryModel> categories ) async {
    try {
      final userId = _validateUser();

      const int batchLimit = 500;

      final dateNow = DateTime.now();
      int year = dateNow.year;
      int month = dateNow.month;

      String date = "$year-${Session.utils.parseNumberLessThan10(month)}";
      int qtdMonths = 0;

      // Cadastra para os próximos 5 anos (60 vezes).
      do {

        for ( int i = 0; i < categories.length; i += batchLimit ) {
          final end = (i + batchLimit < categories.length) ? i + batchLimit : categories.length;
          final WriteBatch batch = db.batch();

          for ( int j = i; j < end; j++ ) {
            CategoryModel category = categories[j];
            final DocumentReference docRef = db.collection("categories").doc(date).collection(userId).doc(category.id);
            batch.set(docRef, category.toJson());
          }

          await batch.commit();
        }

        qtdMonths++;
        if ( month > 12 ) {
          year++;
          month = 1;
        }
        date = "$year-${Session.utils.parseNumberLessThan10(month)}";

      // } while ( qtdMonths < 60 );
      } while ( qtdMonths < 1 );

      if ( Session.user.stepMissing.trim() == StepMissingEnum.categories.name ) {
        db.collection("users").doc(userId).update({
          "step_missing": StepMissingEnum.categoriesSelected.name,
          "updated_at": DateTime.now().toIso8601String(),
        });
      }

    } on UnauthorizedException {
      rethrow;
    } on FirebaseException catch (e, st) {
      Session.crash.onError("createUserCategories_FirebaseException", error: e, stackTrace: st);
      throw ServerExceptions(e.message ?? e.toString());
    } catch (e, st) {
      Session.crash.onError("createUserCategories_error", error: e, stackTrace: st);
      throw GeneralException(e.toString());
    }
  }

  @override
  Future<void> createUserCategory( Map<String, dynamic> json ) async {
    try {
      final userId = _validateUser();

      final dateNow = DateTime.now();
      int year = dateNow.year;
      int month = dateNow.month;

      String date = "$year-${Session.utils.parseNumberLessThan10(month)}";

      final WriteBatch batch = db.batch();
      final DocumentReference docRef = db.collection("categories").doc(date).collection(userId).doc(json["id"]);
      batch.set(docRef, json);
      await batch.commit();

    } on UnauthorizedException {
      rethrow;
    } on FirebaseException catch (e, st) {
      Session.crash.onError("createUserCategory_FirebaseException", error: e, stackTrace: st);
      throw ServerExceptions(e.message ?? e.toString());
    } catch (e, st) {
      Session.crash.onError("createUserCategory_error", error: e, stackTrace: st);
      throw GeneralException(e.toString());
    }
  }

  @override
  Future<void> updateUserCategories( List<CategoryModel> categories ) async {
    try {
      final userId = _validateUser();

      const int batchLimit = 500;

      final dateNow = DateTime.now();
      int year = dateNow.year;
      int month = dateNow.month;

      String date = "$year-${Session.utils.parseNumberLessThan10(month)}";
      int qtdMonths = 0;

      // Cadastra para os próximos 5 anos (60 vezes).
      do {

        for ( int i = 0; i < categories.length; i += batchLimit ) {
          final end = (i + batchLimit < categories.length) ? i + batchLimit : categories.length;
          final WriteBatch batch = db.batch();

          for ( int j = i; j < end; j++ ) {
            CategoryModel category = categories[j];
            print("category => ${category.id}");
            final DocumentReference docRef = db.collection("categories").doc(date).collection(userId).doc(category.id);
            batch.update(docRef, category.updateJson());
          }

          await batch.commit();
        }

        qtdMonths++;
        if ( month > 12 ) {
          year++;
          month = 1;
        }
        date = "$year-${Session.utils.parseNumberLessThan10(month)}";

        // } while ( qtdMonths < 60 );
      } while ( qtdMonths < 1 );

      if ( Session.user.stepMissing.trim() == StepMissingEnum.categoriesSelected.name ) {
        db.collection("users").doc(userId).update({
          "step_missing": StepMissingEnum.accounts.name,
          "updated_at": DateTime.now().toIso8601String(),
        });
      }

    } on UnauthorizedException {
      rethrow;
    } on FirebaseException catch (e, st) {
      Session.crash.onError("updateUserCategories_FirebaseException", error: e, stackTrace: st);
      throw ServerExceptions(e.message ?? e.toString());
    } catch (e, st) {
      Session.crash.onError("updateUserCategories_error", error: e, stackTrace: st);
      throw GeneralException(e.toString());
    }
  }

  @override
  Future<void> updateUserCategory( Map<String, dynamic> json ) async {
    try {
      final userId = _validateUser();
      final dateNow = DateTime.now();
      int year = dateNow.year;
      int month = dateNow.month;

      String date = "$year-${Session.utils.parseNumberLessThan10(month)}";

      final WriteBatch batch = db.batch();
      final DocumentReference docRef = db.collection("categories").doc(date).collection(userId).doc(json["id"]);
      batch.update(docRef, json);
      await batch.commit();

    } on UnauthorizedException {
      rethrow;
    } on FirebaseException catch (e, st) {
      Session.crash.onError("updateUserCategory_FirebaseException", error: e, stackTrace: st);
      throw ServerExceptions(e.message ?? e.toString());
    } catch (e, st) {
      Session.crash.onError("updateUserCategory_error", error: e, stackTrace: st);
      throw GeneralException(e.toString());
    }
  }

  String _validateUser() {
    final user = auth.currentUser;
    if ( user == null ) {
      const errorMessage = "User unauthorized to Get Categories";
      Session.crash.onError("CategoryDataSource _validateUser", error: errorMessage);
      throw UnauthorizedException(errorMessage);
    }

    return user.uid;
  }

  int _getCategoryPriority( CategoryModel category ) {
    if (category.isEssentialExpense) return 0; // 1º
    if (!category.isRevenue) return 1; // 2º
    return 2; // 3º (is_revenue == true)
  }

}