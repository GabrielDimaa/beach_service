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

  _PedidoController(this.pedidoService);

  @observable
  PedidoStore pedidoStore = PedidoStore();

  @observable
  bool loading;

  @override
  Future<void> load() async {
    await toProdutoPage();
  }

  @override
  Future<void> save() async {}

  @override
  Future<void> delete() async {}

  Future<void> toProdutoPage() async {
    await Modular.to.pushNamed('/$PRODUTO_ROUTE');
  }
}
