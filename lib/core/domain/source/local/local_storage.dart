import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocalStorage {
  final _secureStorage = const FlutterSecureStorage();

  Future<void> saveRememberLogin( bool value ) async {
    await _secureStorage.write(key: "remember_login", value: value.toString());
  }

  Future<bool> getRememberLogin() async {
    return bool.tryParse(await _secureStorage.read(key: "remember_login") ?? "true") ?? true;
  }

  Future<void> saveLoginEmail( String email ) async {
    await _secureStorage.write(key: "login_email", value: email);
  }

  Future<String> getLoginEmail() async {
    return await _secureStorage.read(key: "login_email") ?? "";
  }

  Future<void> saveLoginPassword( String password ) async {
    await _secureStorage.write(key: "login_password", value: password);
  }

  Future<String> getLoginPassword() async {
    return await _secureStorage.read(key: "login_password") ?? "";
  }

  Future <void> clearLoginData() async {
    await _secureStorage.delete(key: "remember_login");
    await _secureStorage.delete(key: "login_email");
    await _secureStorage.delete(key: "login_password");
  }

}