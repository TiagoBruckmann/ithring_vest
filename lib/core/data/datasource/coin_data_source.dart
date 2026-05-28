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
    try {

      final snapshot = await db.collection("coins").get();
      return snapshot.docs
          .map((doc) => CoinModel.fromJson(doc.data()))
          .toList()
          ..sort((a, b) => _getCoinPriority(a).compareTo(_getCoinPriority(b)));

    } on FirebaseException catch (e, st) {
      Session.crash.onError("getCoins_FirebaseException", error: e, stackTrace: st);
      throw ServerExceptions(e.message ?? e.toString());
    } catch (e, st) {
      Session.crash.onError("getCoins_error", error: e, stackTrace: st);
      throw GeneralException(e.toString());
    }
  }

  int _getCoinPriority( CoinModel coin ) {
    if ( coin.acronym == "BRL" ) return 0; // 1º
    if ( coin.acronym == "USD" ) return 1; // 2º
    if ( coin.acronym == "GBP" ) return 2; // 3º
    if ( coin.acronym == "EUR" ) return 3; // 4º
    return 5; // >= 5º
  }

 }