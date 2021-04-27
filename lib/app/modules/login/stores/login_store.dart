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

  @action
  void setEmail(String value) => email = value;

  @action
  void setPassword(String value) => password = value;

  _LoginStoreBase({this.id, this.email, this.password});

  LoginDto toDto() {
    return LoginDto(
      BaseDto(id),
      email,
      password,
    );
  }

  void fromDto(LoginDto dto) {
    if (dto != null) {
      this.id = dto.base.id;
      this.email = dto.email;
      this.password = dto.password;
    }
  }
}
