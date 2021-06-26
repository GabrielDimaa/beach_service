import 'package:beach_service/app/app_controller.dart';
import 'package:beach_service/app/modules/home/services/sincronizacao_service.dart';
import 'package:beach_service/app/modules/user/dtos/user_dto.dart';
import 'package:beach_service/app/modules/user/services/user_service_interface.dart';
import 'package:beach_service/app/modules/user/stores/user_store.dart';
import 'package:beach_service/app/shared/components/dialog/alert_dialog_widget.dart';
import 'package:beach_service/app/shared/interfaces/form_controller_interface.dart';
import 'package:beach_service/app/shared/routes/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'user_cadastro_controller.g.dart';

class UserCadastroController = _UserCadastroControllerBase with _$UserCadastroController;

abstract class _UserCadastroControllerBase with Store implements IFormController {
  final IUserService userService;
  final AppController appController;

  _UserCadastroControllerBase(this.userService, this.appController);

  @observable
  UserStore userStore = UserStore();

  @observable
  bool loading = false;

  @observable
  bool primeiroRegistro = false;

  @action
  void setLoading(bool value) => loading = value;

  @action
  void setPrimeiroRegistro(bool value) => primeiroRegistro = value;

  @action
  Future<void> load() async {}

  @action
  Future<void> save() async {
    if (primeiroRegistro && userStore.isVendedor) {
       await Modular.to.pushNamed("/$PRODUTO_ROUTE");
    } else {
      loading = true;
      Modular.get<SincronizacaoService>().stop();

      if (userStore != null) {
        UserDto userDto = userStore.toDto();
        UserDto dto = await userService.saveOrUpdate(userDto);

        if (primeiroRegistro && dto != null)
          Modular.to.pushNamed(Modular.initialRoute);
        else {
          appController.userStore = UserStoreFactory.fromDto(dto);
          Modular.get<SincronizacaoService>().start();

          Modular.to.pop();
        }
      }

      loading = false;
    }
  }

  @action
  Future<void> delete() async {}

  @action
  void avancar(BuildContext context) {
    if (userStore.isConsumidor || userStore.isVendedor)
      Modular.to.pushNamed('/$USER_ROUTE/$USER_CADASTRO_ROUTE');
    else
      AlertDialogWidget.show(context, content: "Você deve selecionar o tipo de conta 'CONSUMIDOR' ou 'VENDEDOR'.");
  }
}
