import 'package:beach_service/app/modules/login/stores/login_store.dart';
import 'package:beach_service/app/shared/preferences/auth_preferences.dart';
import 'package:beach_service/app/shared/routes/routes.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'app_controller.g.dart';

class AppController = _AppController with _$AppController;

abstract class _AppController with Store {
  @observable
  LoginStore loginStore;

  Future<void> _getAuth() async => loginStore = LoginStoreFactory.fromDto(await AuthPreferences().get());

  Future<void> chechAuth({bool aberturaApp = false}) async {
    await _getAuth();

    if (loginStore?.id != null && loginStore?.token != null)
      if (aberturaApp) Modular.to.navigate("/$HOME_ROUTE");
    else
      Modular.to.navigate("$LOGIN_ROUTE");
  }

  Future<void> load() async => await chechAuth(aberturaApp: true);
}