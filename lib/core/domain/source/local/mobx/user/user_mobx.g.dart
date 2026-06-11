// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_mobx.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$UserMobx on _UserMobx, Store {
  late final _$userAtom = Atom(name: '_UserMobx.user', context: context);

  @override
  UserEntity get user {
    _$userAtom.reportRead();
    return super.user;
  }

  @override
  set user(UserEntity value) {
    _$userAtom.reportWrite(value, super.user, () {
      super.user = value;
    });
  }

  late final _$exitAppAsyncAction =
      AsyncAction('_UserMobx.exitApp', context: context);

  @override
  Future<void> exitApp() {
    return _$exitAppAsyncAction.run(() => super.exitApp());
  }

  late final _$_UserMobxActionController =
      ActionController(name: '_UserMobx', context: context);

  @override
  void setUser(UserEntity newUser) {
    final _$actionInfo =
        _$_UserMobxActionController.startAction(name: '_UserMobx.setUser');
    try {
      return super.setUser(newUser);
    } finally {
      _$_UserMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
user: ${user}
    ''';
  }
}
