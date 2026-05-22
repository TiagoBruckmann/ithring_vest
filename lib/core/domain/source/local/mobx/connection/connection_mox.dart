import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:ithring_vest/session.dart';
import 'package:mobx/mobx.dart';
import 'package:injectable/injectable.dart';

part 'connection_mobx.g.dart';

@singleton
class ConnectionMobx extends _ConnectionMobx with _$ConnectionMobx {}

abstract class _ConnectionMobx with Store {

  @observable
  ConnectivityResult connectionStatus = ConnectivityResult.none;

  @observable
  final Connectivity _connectivity = Connectivity();

  @observable
  bool isValidConnection = true;

  @observable
  StreamSubscription<List<ConnectivityResult>>? _subscription;

  @action
  void _setIsValidConnection( bool value ) => isValidConnection = value;

  @action
  Future<void> _verifyConnection() async {

    List<ConnectivityResult> result = [];

    try {
      result.addAll(await _connectivity.checkConnectivity());

      if ( result.contains( ConnectivityResult.bluetooth ) || result.contains( ConnectivityResult.none ) ) {
        return _updateConnectionStatus(ConnectivityResult.none);
      }

      result.removeWhere((connection) => connection == ConnectivityResult.bluetooth || connection == ConnectivityResult.none);
      return _updateConnectionStatus(result.last);

    } on PlatformException catch (e) {
      Session.logs.errorLog("verify_connection_error => ${e.code}");
      return;
    }

  }

  @action
  Future<void> _updateConnectionStatus( ConnectivityResult result ) async {
    connectionStatus = result;

    if ( result == ConnectivityResult.none ) {
      return _setIsValidConnection(false);
    }

    _setIsValidConnection(true);
  }

  @action
  void listenChangeConnectivityState() {
    _subscription = _connectivity.onConnectivityChanged.listen((event) async {
      return await _verifyConnection();
    });
  }

  @action
  void cancelListen() => _subscription?.cancel();
}