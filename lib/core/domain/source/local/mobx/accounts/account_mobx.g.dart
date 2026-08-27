// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_mobx.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AccountMobx on _AccountMobx, Store {
  late final _$totalPatrimonyAmountAtom =
      Atom(name: '_AccountMobx.totalPatrimonyAmount', context: context);

  @override
  double get totalPatrimonyAmount {
    _$totalPatrimonyAmountAtom.reportRead();
    return super.totalPatrimonyAmount;
  }

  @override
  set totalPatrimonyAmount(double value) {
    _$totalPatrimonyAmountAtom.reportWrite(value, super.totalPatrimonyAmount,
        () {
      super.totalPatrimonyAmount = value;
    });
  }

  late final _$defaultAccountAmountAtom =
      Atom(name: '_AccountMobx.defaultAccountAmount', context: context);

  @override
  String get defaultAccountAmount {
    _$defaultAccountAmountAtom.reportRead();
    return super.defaultAccountAmount;
  }

  @override
  set defaultAccountAmount(String value) {
    _$defaultAccountAmountAtom.reportWrite(value, super.defaultAccountAmount,
        () {
      super.defaultAccountAmount = value;
    });
  }

  late final _$emergencyReserveAccountAtom =
      Atom(name: '_AccountMobx.emergencyReserveAccount', context: context);

  @override
  AccountEntity? get emergencyReserveAccount {
    _$emergencyReserveAccountAtom.reportRead();
    return super.emergencyReserveAccount;
  }

  @override
  set emergencyReserveAccount(AccountEntity? value) {
    _$emergencyReserveAccountAtom
        .reportWrite(value, super.emergencyReserveAccount, () {
      super.emergencyReserveAccount = value;
    });
  }

  late final _$getAccountsAsyncAction =
      AsyncAction('_AccountMobx.getAccounts', context: context);

  @override
  Future<void> getAccounts() {
    return _$getAccountsAsyncAction.run(() => super.getAccounts());
  }

  @override
  String toString() {
    return '''
totalPatrimonyAmount: ${totalPatrimonyAmount},
defaultAccountAmount: ${defaultAccountAmount},
emergencyReserveAccount: ${emergencyReserveAccount}
    ''';
  }
}
