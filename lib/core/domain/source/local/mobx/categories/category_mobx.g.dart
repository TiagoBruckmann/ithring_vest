// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_mobx.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CategoryMobx on _CategoryMobx, Store {
  late final _$revenueAmountAtom =
      Atom(name: '_CategoryMobx.revenueAmount', context: context);

  @override
  double get revenueAmount {
    _$revenueAmountAtom.reportRead();
    return super.revenueAmount;
  }

  @override
  set revenueAmount(double value) {
    _$revenueAmountAtom.reportWrite(value, super.revenueAmount, () {
      super.revenueAmount = value;
    });
  }

  late final _$essentialExpenseAmountAtom =
      Atom(name: '_CategoryMobx.essentialExpenseAmount', context: context);

  @override
  double get essentialExpenseAmount {
    _$essentialExpenseAmountAtom.reportRead();
    return super.essentialExpenseAmount;
  }

  @override
  set essentialExpenseAmount(double value) {
    _$essentialExpenseAmountAtom
        .reportWrite(value, super.essentialExpenseAmount, () {
      super.essentialExpenseAmount = value;
    });
  }

  late final _$expenseAmountAtom =
      Atom(name: '_CategoryMobx.expenseAmount', context: context);

  @override
  double get expenseAmount {
    _$expenseAmountAtom.reportRead();
    return super.expenseAmount;
  }

  @override
  set expenseAmount(double value) {
    _$expenseAmountAtom.reportWrite(value, super.expenseAmount, () {
      super.expenseAmount = value;
    });
  }

  late final _$investmentAmountAtom =
      Atom(name: '_CategoryMobx.investmentAmount', context: context);

  @override
  double get investmentAmount {
    _$investmentAmountAtom.reportRead();
    return super.investmentAmount;
  }

  @override
  set investmentAmount(double value) {
    _$investmentAmountAtom.reportWrite(value, super.investmentAmount, () {
      super.investmentAmount = value;
    });
  }

  late final _$essentialLimitExpensePercentageAtom = Atom(
      name: '_CategoryMobx.essentialLimitExpensePercentage', context: context);

  @override
  double get essentialLimitExpensePercentage {
    _$essentialLimitExpensePercentageAtom.reportRead();
    return super.essentialLimitExpensePercentage;
  }

  @override
  set essentialLimitExpensePercentage(double value) {
    _$essentialLimitExpensePercentageAtom
        .reportWrite(value, super.essentialLimitExpensePercentage, () {
      super.essentialLimitExpensePercentage = value;
    });
  }

  late final _$nonEssentialLimitExpensePercentageAtom = Atom(
      name: '_CategoryMobx.nonEssentialLimitExpensePercentage',
      context: context);

  @override
  double get nonEssentialLimitExpensePercentage {
    _$nonEssentialLimitExpensePercentageAtom.reportRead();
    return super.nonEssentialLimitExpensePercentage;
  }

  @override
  set nonEssentialLimitExpensePercentage(double value) {
    _$nonEssentialLimitExpensePercentageAtom
        .reportWrite(value, super.nonEssentialLimitExpensePercentage, () {
      super.nonEssentialLimitExpensePercentage = value;
    });
  }

  late final _$getCategoriesAsyncAction =
      AsyncAction('_CategoryMobx.getCategories', context: context);

  @override
  Future<void> getCategories() {
    return _$getCategoriesAsyncAction.run(() => super.getCategories());
  }

  late final _$_CategoryMobxActionController =
      ActionController(name: '_CategoryMobx', context: context);

  @override
  void _treatLimitExpensePercentages() {
    final _$actionInfo = _$_CategoryMobxActionController.startAction(
        name: '_CategoryMobx._treatLimitExpensePercentages');
    try {
      return super._treatLimitExpensePercentages();
    } finally {
      _$_CategoryMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
revenueAmount: ${revenueAmount},
essentialExpenseAmount: ${essentialExpenseAmount},
expenseAmount: ${expenseAmount},
investmentAmount: ${investmentAmount},
essentialLimitExpensePercentage: ${essentialLimitExpensePercentage},
nonEssentialLimitExpensePercentage: ${nonEssentialLimitExpensePercentage}
    ''';
  }
}
