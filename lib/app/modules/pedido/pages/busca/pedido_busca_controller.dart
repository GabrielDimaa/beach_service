import 'package:beach_service/app/modules/pedido/pages/pedido_controller.dart';
import 'package:beach_service/app/modules/pedido/stores/pedido_store.dart';
import 'package:mobx/mobx.dart';

part 'pedido_busca_controller.g.dart';

class PedidoBuscaController = _PedidoBuscaController with _$PedidoBuscaController;

abstract class _PedidoBuscaController with Store {
  final PedidoController pedidoController;

  _PedidoBuscaController(this.pedidoController);

  @observable
  List<PedidoStore> pedidos = ObservableList<PedidoStore>();

  @observable
  int pageController = 0;

  @action
  void setPageController(int value) => pageController = value;

  Future<void> load() async {

  }
}