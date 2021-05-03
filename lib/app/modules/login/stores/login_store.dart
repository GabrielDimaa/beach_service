import 'package:beach_service/app/modules/login/dtos/login_dto.dart';
import 'package:beach_service/app/shared/dtos/base_dto.dart';
import 'package:mobx/mobx.dart';

part 'login_store.g.dart';

class LoginStore = _LoginStoreBase with _$LoginStore;

abstract class _LoginStoreBase with Store {
  int id;

  @observable
  String email;

  @observable
  String password;

  @observable
  String token;

  @action
  void setEmail(String value) => email = value;

  @action
  void setPassword(String value) => password = value;

  @action
  void setToken(String value) => token = value;

  _LoginStoreBase({this.id, this.email, this.password, this.token});

  LoginDto toDto() {
    return LoginDto(
      base: BaseDto(id),
      email: email,
      password: password,
      token: token,
    );
  }
}

abstract class LoginStoreFactory {
  static LoginStore fromDto(LoginDto dto) {
    if (dto != null) {
      return LoginStore(
        id: dto.base.id,
        email: dto.email,
        token: dto.token,
      );
    } else {
      return null;
    }
  }
}