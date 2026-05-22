import 'package:mobx/mobx.dart';
import 'package:injectable/injectable.dart';

part 'user_mobx.g.dart';

@lazySingleton
class UserMobx extends _UserMobx with _$UserMobx {}

abstract class _UserMobx with Store {

}