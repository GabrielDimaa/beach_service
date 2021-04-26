import 'package:mobx/mobx.dart';

part 'login_store.g.dart';

class LoginStore = _LoginStoreBase with _$LoginStore;

abstract class _LoginStoreBase with Store {
  @observable
  String email;

  @observable
  String password;

  @action
  void setEmail(String value) => email = value;

  @action
  void setPassword(String value) => password = value;
}
