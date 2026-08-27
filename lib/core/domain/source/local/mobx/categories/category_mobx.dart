import 'package:injectable/injectable.dart';
import 'package:ithring_vest/core/domain/entities/category_entity.dart';
import 'package:ithring_vest/core/domain/source/local/injection/injection.dart';
import 'package:ithring_vest/core/domain/usecases/category_use_case.dart';
import 'package:ithring_vest/design_system/widgets/toast_widget.dart';
import 'package:ithring_vest/session.dart';
import 'package:mobx/mobx.dart';

part 'category_mobx.g.dart';

@lazySingleton
class CategoryMobx extends _CategoryMobx with _$CategoryMobx {}

abstract class _CategoryMobx with Store {

  final _categoryUseCase = CategoryUseCase(getIt());

  ObservableList<CategoryEntity> categoriesList = ObservableList();

  @observable
  double revenueAmount = 0;

  @observable
  double essentialExpenseAmount = 0;

  @observable
  double expenseAmount = 0;

  @observable
  double investmentAmount = 0;

  @observable
  double essentialLimitExpensePercentage = 0;

  @observable
  double nonEssentialLimitExpensePercentage = 0;

  @action
  Future<void> getCategories() async {
    final response = await _categoryUseCase.getUserCategories();

    response.fold(
      ( failure ) => showError(failure.message),
      ( accounts ) {
        categoriesList.addAll(accounts);

        _treatLimitExpensePercentages();

      },
    );
  }

  @action
  void _treatLimitExpensePercentages() {

    double essentialSpent = 0;
    double nonEssentialSpent = 0;

    for ( final category in categoriesList ) {

      if ( category.isRevenue ) {
        revenueAmount += category.valueSpent;
      } else {

        if ( category.isEssentialExpense ) {
          essentialSpent += category.valueSpent;
        }

        if ( !category.isEssentialExpense ) {
          nonEssentialSpent += category.valueSpent;
        }

      }

    }


    final essentialLimit = revenueAmount * Session.user.financialBalance.essentialExpenses;
    final nonEssentialLimit = revenueAmount * Session.user.financialBalance.nonEssentialExpenses;

    essentialExpenseAmount = essentialSpent;
    expenseAmount = essentialSpent + nonEssentialSpent;
    essentialLimitExpensePercentage = Session.utils.percentageMathOperation(essentialLimit, essentialSpent);
    nonEssentialLimitExpensePercentage = Session.utils.percentageMathOperation(nonEssentialLimit, nonEssentialSpent);

  }

}