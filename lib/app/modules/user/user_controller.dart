import 'package:beach_service/app/modules/user/dtos/user_dto.dart';
import 'package:beach_service/app/modules/user/services/user_service_interface.dart';
import 'package:beach_service/app/modules/user/stores/user_store.dart';
import 'package:beach_service/app/shared/components/dialog/alert_dialog_widget.dart';
import 'package:beach_service/app/shared/interfaces/form_controller_interface.dart';
import 'package:beach_service/app/shared/routes/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'user_controller.g.dart';

class UserController = _UserControllerBase with _$UserController;

abstract class _UserControllerBase with Store implements IFormController {
  final IUserService userService;

  _UserControllerBase(this.userService);

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

      if (userStore != null) {
        UserDto userDto = userStore.toDto();
        UserDto dto = await userService.saveOrUpdate(userDto);

        if (dto != null)
          Modular.to.pushNamed(Modular.initialRoute);
      }

      loading = false;
    }
  }

  @action
  Future<void> delete() async {}

  @action
  void avancar(BuildContext context) {
    if (userStore.isConsumidor || userStore.isVendedor)
      Modular.to.pushNamed('/$USER_ROUTE');
    else
      AlertDialogWidget.show(context, content: "Você deve selecionar o tipo de conta 'CONSUMIDOR' ou 'VENDEDOR'.");
  }
}
