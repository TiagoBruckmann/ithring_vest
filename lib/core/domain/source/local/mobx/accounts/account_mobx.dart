import 'package:injectable/injectable.dart';
import 'package:ithring_vest/core/domain/entities/account_entity.dart';
import 'package:ithring_vest/core/domain/source/local/injection/injection.dart';
import 'package:ithring_vest/core/domain/source/local/mobx/categories/category_mobx.dart';
import 'package:ithring_vest/core/domain/usecases/account_use_case.dart';
import 'package:ithring_vest/design_system/widgets/toast_widget.dart';
import 'package:mobx/mobx.dart';

part 'account_mobx.g.dart';

@lazySingleton
class AccountMobx extends _AccountMobx with _$AccountMobx {}

abstract class _AccountMobx with Store {

  final _accountUseCase = AccountUseCase(getIt());

  ObservableList<AccountEntity> accountList = ObservableList();

  @observable
  AccountEntity? emergencyReserveAccount;

  @action
  Future<void> getAccounts() async {
    final response = await _accountUseCase.getUserAccounts();

    response.fold(
      ( failure ) => showError(failure.message),
      ( accounts ) async {
        final categoryMobx = getIt<CategoryMobx>();
        await categoryMobx.getCategories();

        accountList.addAll(accounts);
        final emergencyReserve = accountList.firstWhere((account) => account.name.contains("emergency_reserve"), orElse: () => AccountEntity.empty());

        if ( emergencyReserve.id.trim().isNotEmpty ) {
          emergencyReserveAccount = emergencyReserve;
        }

      },
    );
  }

}