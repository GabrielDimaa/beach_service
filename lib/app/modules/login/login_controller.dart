import 'package:beach_service/app/modules/login/stores/login_store.dart';
import 'package:mobx/mobx.dart';

part 'login_controller.g.dart';

class LoginController = _LoginControllerBase with _$LoginController;

abstract class _LoginControllerBase with Store {
  @observable
  LoginStore loginStore;

  @action
  Future<void> login() async {}

  @action
  Future<void> registrar() async {}
}
