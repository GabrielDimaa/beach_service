import 'package:beach_service/app/modules/login/dtos/login_dto.dart';
import 'package:beach_service/app/modules/login/services/login_service_interface.dart';
import 'package:beach_service/app/modules/login/stores/login_store.dart';
import 'package:beach_service/app/modules/produto/produto_controller.dart';
import 'package:beach_service/app/modules/user/dtos/user_dto.dart';
import 'package:beach_service/app/modules/user/services/user_service_interface.dart';
import 'package:beach_service/app/modules/user/stores/user_store.dart';
import 'package:beach_service/app/modules/user/user_controller.dart';
import 'package:beach_service/app/shared/components/loading.dart';
import 'package:beach_service/app/shared/interfaces/form_controller_interface.dart';
import 'package:beach_service/app/shared/preferences/auth_preferences.dart';
import 'package:beach_service/app/shared/routes/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'login_controller.g.dart';

class LoginController = _LoginControllerBase with _$LoginController;

abstract class _LoginControllerBase with Store implements IFormController {
  final ILoginService loginService;

  _LoginControllerBase(this.loginService);

  @observable
  LoginStore loginStore = LoginStore();

  @observable
  bool loading = false;

  @action
  void setLoading(bool value) => loading = value;

  @override
  Future<void> load() async {}

  @action
  Future<void> login(BuildContext context) async {
    try {
      loading = true;

      if (loginStore != null) {
        await loginService.auth(loginStore.toDto());

        loading = false;

        Modular.to.pushNamed('/$HOME_ROUTE');
      }
    } catch(e) {
      rethrow;
    } finally {
      loading = false;
    }
  }

  @action
  Future<void> registrar() async {
    Modular.to.pushNamed("$USER_ROUTE/$TIPO_USER_ROUTE");
  }

  @override
  Future<void> save() async {}

  @override
  Future<void> delete() async {}
}
