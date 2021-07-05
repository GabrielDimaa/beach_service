import 'package:beach_service/app/app_controller.dart';
import 'package:beach_service/app/modules/home/services/sincronizacao_service_interface.dart';
import 'package:beach_service/app/modules/pedido/dtos/pedido_dto.dart';
import 'package:beach_service/app/modules/pedido/enums/enum_status_pedido.dart';
import 'package:beach_service/app/modules/pedido/services/pedido_service_interface.dart';
import 'package:beach_service/app/modules/pedido/stores/pedido_store.dart';
import 'package:beach_service/app/shared/components/dialog/alert_dialog_widget.dart';
import 'package:beach_service/app/shared/constants/page.dart';
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
  final ISincronizacaoService sincronizacaoService;

  _PedidoController(this.pedidoService, this.appController, this.sincronizacaoService);

  @observable
  PedidoStore pedidoStore = PedidoStoreFactory.novo();

  @observable
  bool loading;
  
  @observable
  BuildContext context;
  
  @action
  void setContext(BuildContext value) => context = value;

  @computed
  bool get pedidoRealizado => pedidoStore.id != null;

  @computed
  bool get statusIsNotNull => pedidoStore.statusPedido != null;
  EnumStatusPedido get nextStatusPedido {
    if (statusIsNotNull) {
      if (pedidoStore.statusPedido == EnumStatusPedido.EmAberto)
        return EnumStatusPedido.Aceito;
      else if (pedidoStore.statusPedido == EnumStatusPedido.Aceito)
        return EnumStatusPedido.Finalizado;
    }
    return null;
  }

  @override
  Future<void> load() async {
    if (!(pedidoStore.id != null)) {
      toProdutoPage().then((value) {
        pedidoStore.userConsumidor = appController.userStore;
        pedidoStore.loadPedido();

        if ((pedidoStore.itensPedido?.length ?? 0) == 0)
          Modular.to.pop();
      });
    }
  }

  @override
  Future<void> save() async {
    try {
      if ((pedidoStore?.itensPedido?.length ?? 0) == 0) throw Exception("Escolha ao menos um produto.");

      pedidoStore.statusPedido = EnumStatusPedido.EmAberto;

      loading = true;
      PedidoDto dto = await pedidoService.saveOrUpdate(pedidoStore.toDto());

      if (dto.base.id == null) throw Exception("Houve um erro ao enviar seu pedido.");

      AlertDialogWidget.show(context, content: "Pedido enviado com sucesso!");
      Future.delayed(Duration(milliseconds: 1000), () {
        appController.setPage(HOME_PAGE);
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

  @action
  Future<void> toProdutoPage() async {
    await Modular.to.pushNamed('/$PRODUTO_ROUTE');
  }

  @action
  Future<void> cancelarPedido() async {

  }

  @action
  Future<void> atualizarStatus() async {
    try {
      sincronizacaoService.stop();

      PedidoStore pedidoStore = this.pedidoStore.clone();
      pedidoStore.setStatusPedido(nextStatusPedido);
      pedidoStore = PedidoStoreFactory.fromDto(await pedidoService.saveOrUpdate(pedidoStore.toDto()));

      if (pedidoStore.statusPedido != this.pedidoStore.statusPedido)
        this.pedidoStore.setStatusPedido(pedidoStore.statusPedido);
    } catch (e) {
      await sincronizacaoService.start();
      rethrow;
    } finally {
      await sincronizacaoService.start();
    }
  }
}
