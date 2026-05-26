import 'package:injectable/injectable.dart';
import 'package:ithring_vest/core/data/exceptions/exception.dart';
import 'package:ithring_vest/core/data/model/category_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ithring_vest/session.dart';

abstract class CategoryDataSource {
  Future<List<CategoryModel>> getDefaultCategories();
  Future<List<CategoryModel>> getUserCategories( String documentId );
  Future<void> createUserCategory( Map<String, dynamic> json );
  Future<void> updateUserCategory( Map<String, dynamic> json );
}

@Injectable(as: CategoryDataSource)
class CategoryDataSourceImpl implements CategoryDataSource {
  final FirebaseFirestore db;
  final FirebaseAuth auth;
  CategoryDataSourceImpl( this.db, this.auth );

  @override
  Future<List<CategoryModel>> getDefaultCategories() async {
    // TODO: implement getDefaultCategories
    throw UnimplementedError();
  }

  @override
  Future<List<CategoryModel>> getUserCategories( String documentId ) async {
    final userId = _validateUser();

    List<CategoryModel> list = [];
    await db.collection("categories")
      .doc(documentId)
      .collection(userId)
      .get()
      .then((value) {
          for ( final item in value.docs ) {
            list.add(CategoryModel.fromJson(item.data()));
          }
        })
    .onError((error, stackTrace) {
      Session.crash.onError(error.toString(), error: error, stackTrace: stackTrace);
      throw ServerExceptions(error.toString());
    })
    .catchError((onError) {
      Session.crash.log(onError);
      throw ServerExceptions(onError.toString());
    });

    return list;
  }

  @override
  Future<void> createUserCategory(Map<String, dynamic> json) async {
    final userId = _validateUser();
  }

  @override
  Future<void> updateUserCategory(Map<String, dynamic> json) async {
    final userId = _validateUser();
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
}