import 'dart:async';
import 'package:beach_service/app/modules/home/home_controller.dart';
import 'package:beach_service/app/modules/home/services/sincronizacao_service_interface.dart';
import 'package:beach_service/app/modules/user/dtos/user_dto.dart';
import 'package:beach_service/app/modules/user/dtos/user_prod_dto.dart';
import 'package:beach_service/app/modules/user/stores/user_store.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

class SincronizacaoService implements ISincronizacaoService {
  static Timer _timer;

  @override
  Future<void> runner() async {
    print("## Buscando Sincronização ##");

    HomeController controller = Modular.get<HomeController>();

    //region Sincronizar dados do usuário local
    await controller.getLocalization();
    controller.appController.userStore.setIsOnline(true);

    UserDto userDto = controller.appController.userStore.toDto();
    controller.appController.userStore = UserStoreFactory.fromDto(await controller.userService.saveOrUpdate(userDto));
    //endregion

    //region Sincronizar dados de todos usuários
    List<UserProdDto> listUsers = await controller.userService.getAllUserProd(userDto).asObservable();
    listUsers.removeWhere((element) => element.base.id == controller?.appController?.userStore?.id ?? 0);

    controller.users = ObservableList();
    controller.users.addAll(listUsers);
    //endregion

    //Atualizar localizações no mapa
    controller.updateMarkers();

    print("## Sincronização Finalizada ##");
  }

  @override
  Future<void> start({BuildContext context}) async {
    print("## Iniciando sincronização ##");

    if (_timer == null || !_timer.isActive) {
      _timer = Timer.periodic(Duration(seconds: 60), (timer) async {
        await runner();
      });
    }
  }

  @override
  void stop() {
    print("## Parando sincronização ##");
    _timer?.cancel();
  }
}
