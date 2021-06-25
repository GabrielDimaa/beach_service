import 'package:beach_service/app/app_controller.dart';
import 'package:beach_service/app/modules/pedido/services/pedido_service_interface.dart';
import 'package:beach_service/app/modules/pedido/stores/pedido_store.dart';
import 'package:beach_service/app/shared/interfaces/form_controller_interface.dart';
import 'package:beach_service/app/shared/routes/routes.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'pedido_controller.g.dart';

class PedidoController = _PedidoController with _$PedidoController;

abstract class _PedidoController with Store implements IFormController {
  final IPedidoService pedidoService;
  final AppController appController;

  _PedidoController(this.pedidoService, this.appController);

  @observable
  PedidoStore pedidoStore = PedidoStore();

  @observable
  bool loading;

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
      await pedidoService.saveOrUpdate(pedidoStore.toDto());
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
