import 'package:beach_service/app/app_controller.dart';
import 'package:beach_service/app/modules/pedido/dtos/pedido_dto.dart';
import 'package:beach_service/app/modules/pedido/services/pedido_service_interface.dart';
import 'package:beach_service/app/modules/pedido/stores/pedido_store.dart';
import 'package:beach_service/app/shared/components/dialog/alert_dialog_widget.dart';
import 'package:beach_service/app/shared/interfaces/form_controller_interface.dart';
import 'package:beach_service/app/shared/routes/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'pedido_controller.g.dart';

class PedidoController = _PedidoController with _$PedidoController;

abstract class _PedidoController with Store implements IFormController {
  final IPedidoService pedidoService;
  final AppController appController;

  _PedidoController(this.pedidoService, this.appController);

  @observable
  PedidoStore pedidoStore = PedidoStoreFactory.novo();

  @observable
  bool loading;
  
  @observable
  BuildContext context;
  
  @action
  void setContext(BuildContext value) => context = value;

  @override
  Future<void> load() async {
    pedidoStore.userConsumidor = appController.userStore;
    pedidoStore.setLat(pedidoStore.userConsumidor?.lat);
    pedidoStore.setLng(pedidoStore.userConsumidor?.lng);

    await toProdutoPage().then((value) {
      if ((pedidoStore.itensPedido?.length ?? 0) == 0)
        Modular.to.pop();
    });
  }

  @override
  Future<void> save() async {
    try {
      if ((pedidoStore?.itensPedido?.length ?? 0) == 0) throw Exception("Escolha ao menos um produto.");

      loading = true;
      PedidoDto dto = await pedidoService.saveOrUpdate(pedidoStore.toDto());

      if (dto.base.id == null) throw Exception("Houve um erro ao enviar seu pedido.");

      AlertDialogWidget.show(context, content: "Pedido enviado com sucesso!");
      Future.delayed(Duration(milliseconds: 1000), () {
        Modular.to.navigate("/$HOME_ROUTE");
      });
    } catch(e) {
      rethrow;
    } finally {
      loading = false;
    }
  }

  @override
  Future<void> delete() async {}

  Future<void> toProdutoPage() async {
    await Modular.to.pushNamed('/$PRODUTO_ROUTE');
  }
}
