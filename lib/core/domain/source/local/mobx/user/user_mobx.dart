import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:ithring_vest/core/domain/entities/user_entity.dart';
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

  @action
  void setUser( UserEntity newUser ) {
    Session.notifications.login(newUser.id);
    Session.crash.userConnected(newUser.id);
    Session.user = newUser;
    user = newUser;
  }

  @action
  Future<void> exitApp() async {
    return await showCustomDialog(
      showDefaultDialog(
        title: "modal.exit_app.title",
        body: Text(
          FlutterI18n.translate(_context, "modal.exit_app.subtitle"),
          style: Theme.of(_context).textTheme.titleMedium,
          textAlign: TextAlign.center,
        ),
        confirmFunction: () => SystemChannels.platform.invokeMethod('SystemNavigator.pop'),
      ),
    );
  }

}