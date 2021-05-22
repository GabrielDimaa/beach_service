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

    //Atualizar dados do usuário
    UserDto userDto = await controller.userService.saveOrUpdate(controller.userStore.toDto());
    controller.userStore = UserStoreFactory.fromDto(userDto);

    //Pegar usuários
    List<UserProdDto> listUsers = await controller.userService.getAllUserProd(userDto).asObservable();
    listUsers.removeWhere((element) => element.base.id == controller?.userStore?.id ?? 0);

    controller.users = ObservableList();
    controller.users.addAll(listUsers);

    controller.getMyMarker();
    controller.getUsersMakers();
    controller.addMarkers();

    print("## Sincronização Finalizada ##");
  }

  @override
  Future<void> start({BuildContext context}) async {
    print("## Iniciando sincronização ##");

    if (_timer == null || !_timer.isActive) {
      _timer = Timer.periodic(Duration(seconds: 40), (timer) async {
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
