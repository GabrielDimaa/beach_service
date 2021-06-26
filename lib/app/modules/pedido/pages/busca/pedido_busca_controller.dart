import 'package:beach_service/app/modules/pedido/dtos/pedido_dto.dart';
import 'package:beach_service/app/modules/pedido/pages/pedido_controller.dart';
import 'package:beach_service/app/modules/pedido/repositories/pedido_repository_interface.dart';
import 'package:beach_service/app/modules/pedido/services/pedido_service_interface.dart';
import 'package:beach_service/app/modules/pedido/stores/pedido_store.dart';
import 'package:mobx/mobx.dart';

part 'pedido_busca_controller.g.dart';

class PedidoBuscaController = _PedidoBuscaController with _$PedidoBuscaController;

abstract class _PedidoBuscaController with Store {
  final IPedidoRepository pedidoRepository;
  final IPedidoService pedidoService;
  final PedidoController pedidoController;

  _PedidoBuscaController(this.pedidoRepository, this.pedidoService, this.pedidoController);

  @observable
  ObservableList<PedidoStore> pedidos = ObservableList<PedidoStore>();

  @observable
  bool loading = false;

  @action
  void setLoading(bool value) => loading = value;

  Future<void> load() async {
    try {
      setLoading(true);

      List<PedidoDto> pedidosDto = await pedidoService.getAll();
      pedidosDto.forEach((e) {
        pedidos.add(PedidoStoreFactory.fromDto(e)) as ObservableList;
      });
    } catch(e) {
      rethrow;
    } finally {
      setLoading(false);
    }
  }
}