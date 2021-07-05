import 'package:beach_service/app/app_controller.dart';
import 'package:beach_service/app/modules/pedido/dtos/pedido_dto.dart';
import 'package:beach_service/app/modules/pedido/pages/pedido_controller.dart';
import 'package:beach_service/app/modules/pedido/services/pedido_service_interface.dart';
import 'package:beach_service/app/modules/pedido/stores/pedido_store.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'pedido_busca_controller.g.dart';

class PedidoBuscaController = _PedidoBuscaController with _$PedidoBuscaController;

abstract class _PedidoBuscaController with Store {
  final IPedidoService pedidoService;
  final PedidoController pedidoController;

  _PedidoBuscaController(this.pedidoService, this.pedidoController);

  @observable
  ObservableList<PedidoStore> pedidos = ObservableList<PedidoStore>();

  @observable
  bool loading = false;

  @action
  void setLoading(bool value) => loading = value;

  @action
  Future<void> load() async {
    try {
      setLoading(true);

      List<PedidoDto> pedidosDto = await pedidoService.getAll(params: (Modular.get<AppController>()).userStore.id);
      pedidos = pedidosDto.map((e) => PedidoStoreFactory.fromDto(e)).toList().asObservable();
    } catch(e) {
      rethrow;
    } finally {
      setLoading(false);
    }
  }

  @computed
  String get message {
    if (pedidoController.appController.userStore.isVendedor)
      return "Receba pedidos para aparecer aqui.";
    else
      return "Nem um pedido realizado.\nFaça um pedido para aparecer aqui.";
  }
}