import 'package:beach_service/app/modules/login/dtos/login_dto.dart';
import 'package:beach_service/app/modules/login/services/login_service_interface.dart';
import 'package:beach_service/app/modules/login/stores/login_store.dart';
import 'package:beach_service/app/modules/user/dtos/user_dto.dart';
import 'package:beach_service/app/modules/user/services/user_service_interface.dart';
import 'package:beach_service/app/shared/routes/routes.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'login_controller.g.dart';

class LoginController = _LoginControllerBase with _$LoginController;

abstract class _LoginControllerBase with Store {
  final ILoginService loginService;
  final IUserService userService;

  _LoginControllerBase(this.loginService, this.userService);

  @observable
  LoginStore loginStore = LoginStore();

  @observable
  bool loading = false;

  @action
  void setLoading(bool value) => loading = value;

  @action
  Future<void> login() async {
    loading = true;

    if (loginStore != null) {
      LoginDto loginDto = loginStore.toDto();
      loginDto = await loginService.auth(loginDto);

      loginStore.setToken(loginDto.token);

      UserDto userDto = await userService.getById(loginDto.base.id, loginDto: loginDto);

      if (userDto != null)
        Modular.to.pushNamed('/$HOME_ROUTE');
    }

    loading = false;
  }

  @action
  Future<void> registrar() async {
    Modular.to.pushNamed("$USER_ROUTE/$TIPO_USER_ROUTE");
  }
}
