import 'package:beach_service/app/modules/pedido/dtos/pedido_dto.dart';
import 'package:beach_service/app/modules/produto/dtos/produto_dto.dart';
import 'package:beach_service/app/modules/user/dtos/user_prod_dto.dart';
import 'package:beach_service/app/modules/user/stores/user_store.dart';
import 'package:beach_service/app/shared/dtos/base_dto.dart';
import 'package:mobx/mobx.dart';

part 'pedido_store.g.dart';

class PedidoStore = _PedidoStore with _$PedidoStore;

abstract class _PedidoStore with Store {
  @observable
  int id;

  @observable
  double lat;

  @observable
  double lng;

  @observable
  UserStore userConsumidor;

  @observable
  UserProdDto userVendedor;

  @observable
  List<ProdutoDto> itensPedido = ObservableList<ProdutoDto>();

  @observable
  DateTime dataHoraCriado;

  @observable
  DateTime dataHoraFinalizado;

  @action
  void setLat(double value) => lat = value;

  @action
  void setLng(double value) => lng = value;

  @action
  void setUserConsumidor(UserStore value) => userConsumidor = value;

  @action
  void setUserVendedor(UserProdDto value) => userVendedor = value;

  @action
  void setDataHoraCriado(DateTime value) => dataHoraCriado = value;

  @action
  void setDataHoraFinalizado(DateTime value) => dataHoraFinalizado = value;

  @action
  void setItensPedido(List<ProdutoDto> value) => itensPedido = value;

  PedidoDto toDto() {
    return PedidoDto(
      BaseDto(id),
      lat,
      lng,
      userVendedor,
      userConsumidor.toDto(),
      dataHoraCriado,
      dataHoraFinalizado,
      itensPedido,
    );
  }

  _PedidoStore(
    this.id,
    this.lat,
    this.lng,
    this.userConsumidor,
    this.userVendedor,
    this.itensPedido,
    this.dataHoraCriado,
    this.dataHoraFinalizado,
  );
}

abstract class PedidoStoreFactory {
  static PedidoStore fromDto(PedidoDto dto) {
    if (dto != null) {
      return PedidoStore(
        dto.base.id,
        dto.lat,
        dto.lng,
        UserStoreFactory.fromDto(dto.userConsumidor),
        dto.userVendedor,
        dto.itensPedido,
        dto.dataHoraCriado,
        dto.dataHoraFinalizado,
      );
    } else {
      return null;
    }
  }

  static PedidoStore novo() {
    return PedidoStore(
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
    );
  }
}
