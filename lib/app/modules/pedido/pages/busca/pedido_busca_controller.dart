import 'package:beach_service/app/app_controller.dart';
import 'package:beach_service/app/modules/pedido/dtos/pedido_dto.dart';
import 'package:beach_service/app/modules/pedido/pages/pedido_controller.dart';
import 'package:beach_service/app/modules/pedido/services/pedido_service_interface.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'pedido_busca_controller.g.dart';

class PedidoBuscaController = _PedidoBuscaController with _$PedidoBuscaController;

abstract class _PedidoBuscaController with Store {
  final IPedidoService pedidoService;
  final PedidoController pedidoController;

  _PedidoBuscaController(this.pedidoService, this.pedidoController);

  @observable
  ObservableList<PedidoDto> pedidos = ObservableList<PedidoDto>();

  @observable
  bool loading = false;

  @action
  void setLoading(bool value) => loading = value;

  @action
  Future<void> load() async {
    try {
      setLoading(true);

      pedidos.addAll(await pedidoService.getAll(params: (Modular.get<AppController>()).userStore.id).asObservable());
    } catch(e) {
      rethrow;
    } finally {
      setLoading(false);
    }
  }
}