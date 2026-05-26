import 'package:injectable/injectable.dart';
import 'package:ithring_vest/core/data/exceptions/exception.dart';
import 'package:ithring_vest/core/data/model/coin_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ithring_vest/session.dart';

abstract class CoinDataSource {
  Future<List<CoinModel>> getCoins();
}

@Injectable(as : CoinDataSource)
class CoinDataSourceImpl implements CoinDataSource {
  final FirebaseFirestore db;
  CoinDataSourceImpl( this.db );

  @override
  Future<List<CoinModel>> getCoins() async {
    List<CoinModel> list = [];
    await db.collection("coins")
      .get()
      .then((value) {
          for ( final item in value.docs ) {
            list.add(CoinModel.fromJson(item.data()));
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

 }