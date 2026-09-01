import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:ithring_vest/core/domain/entities/user_entity.dart';
import 'package:ithring_vest/core/domain/source/local/injection/injection.dart';
import 'package:ithring_vest/core/domain/source/local/mobx/accounts/account_mobx.dart';
import 'package:ithring_vest/core/domain/source/local/mobx/categories/category_mobx.dart';
import 'package:ithring_vest/design_system/widgets/dialog_widget.dart';
import 'package:ithring_vest/session.dart';
import 'package:mobx/mobx.dart';
import 'package:injectable/injectable.dart';

part 'user_mobx.g.dart';

@lazySingleton
class UserMobx extends _UserMobx with _$UserMobx {}

abstract class _UserMobx with Store {

  final _context = Session.globalContext.currentContext!;

  @observable
  UserEntity user = UserEntity.empty();

  @observable
  String greeting = "morning";

  @action
  void _setUser( UserEntity newUser ) {
    user = newUser;
  }

  @action
  void _getGreeting() {
    final hour = DateTime.now().hour;
    if ( hour >= 5 && hour < 12 ) {
      greeting = "morning";
    } else if ( hour >= 12 && hour < 18 ) {
      greeting = "afternoon";
    } else {
      greeting = "evening";
    }
  }

  @action
  void setUser( UserEntity newUser ) {
    // Session.notifications.login(newUser.id);
    Session.crash.userConnected(newUser.id);
    Session.user = newUser;
    _setUser(newUser);
    _getGreeting();
    _setFinancialHealth();
  }

  @action
  Future<void> _setFinancialHealth() async {

    final accountMobx = getIt<AccountMobx>();
    final categoryMobx = getIt<CategoryMobx>();

    await Future.wait([
      accountMobx.getAccounts()
    ]);

    final List<Map<String, dynamic>> financialStatus = [
      {
        "name": "essential_limit_expense",
        "percentage": categoryMobx.essentialLimitExpensePercentage,
      },
      {
        "name": "non_essential_limit_expense",
        "percentage": categoryMobx.nonEssentialLimitExpensePercentage,
      },
    /*
      {
        "name": "credit_card_expense",
        "percentage": 70,
      }
      */
    ];

    final suggestedEmergencyReserve = categoryMobx.essentialExpenseAmount * user.settings.qtdMonthsEmergencyReserve;
    double parsedEmergencyReserve = 0;
    final hasEmergencyReserve = accountMobx.emergencyReserveAccount != null;
    if ( hasEmergencyReserve ) {
      parsedEmergencyReserve = Session.coinFormatter.coinToDouble(accountMobx.emergencyReserveAccount!.amount);

      financialStatus.add({
        "name": "emergency_reserve",
        "percentage": Session.utils.percentageMathOperation(suggestedEmergencyReserve, parsedEmergencyReserve),
      });

    }

    double sumPercentages = 0;
    for ( final item in financialStatus ) {
      sumPercentages += item["percentage"];
    }

    final averagePercentage = (sumPercentages / financialStatus.length).round();

    String overallName = "good";
    if ( averagePercentage > 80 ) {
      overallName = "bad_score";
    } else if ( averagePercentage > 50 ) {
      overallName = "right_way";
    }

    String? detailedMessage;
    if ( categoryMobx.essentialLimitExpensePercentage >= 100 ) {
      detailedMessage = "over_essential_expenses";
    } else if ( categoryMobx.nonEssentialLimitExpensePercentage >= 100 ) {
      detailedMessage = "over_non_essential_expenses";
    } else if ( !hasEmergencyReserve ) {
      detailedMessage = "no_emergency_reserve";
    } else if ( hasEmergencyReserve && parsedEmergencyReserve < suggestedEmergencyReserve ) {
      detailedMessage = "emergency_reserve_not_enough";
    } else if ( categoryMobx.expenseAmount > 0 && categoryMobx.expenseAmount >= categoryMobx.revenueAmount ) {
      detailedMessage = "expend_more_than_salary";
    } else if ( categoryMobx.expenseAmount > 0 && categoryMobx.expenseAmount >= categoryMobx.revenueAmount && !hasEmergencyReserve ) {
      detailedMessage = "expend_more_than_salary_without_reserve";
    }/* else if ( isCreditCardHighExpense ) {
      detailedMessage = "credit_card_high_expense";
    }
    */

    UserFinancialHealth userFinancialHealth = UserFinancialHealth.empty();
    userFinancialHealth = userFinancialHealth.copyWith(
      name: overallName,
      percentage: averagePercentage,
      detailedMessage: detailedMessage,
    );

    _setUser(
      user.copyWith(
        financialHealth: userFinancialHealth,
      ),
    );

  }

  @action
  Future<void> exitApp() async {
    return await showCustomDialog(
      showDefaultDialog(
        title: "modal.exit_app.title",
        body: Text(
          FlutterI18n.translate(_context, "modal.exit_app.subtitle"),
          style: Theme.of(_context).textTheme.titleMedium,
          textAlign: TextAlign.start,
        ),
        confirmFunction: () => SystemChannels.platform.invokeMethod('SystemNavigator.pop'),
      ),
    );
  }

}