import 'package:beach_service/app/modules/pedido/dtos/pedido_dto.dart';
import 'package:beach_service/app/modules/pedido/enums/enum_status_pedido.dart';
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
  double distance;

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

  @observable
  EnumStatusPedido statusPedido;

  @action
  void setLat(double value) => lat = value;

  @action
  void setLng(double value) => lng = value;

  @action
  void setDistance(double value) => distance = value;

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

  @action
  void setStatusPedido(EnumStatusPedido value) => statusPedido = value;

  @action
  void loadPedido() {
    setLat(userConsumidor?.lat);
    setLng(userConsumidor?.lng);
    setDistance(userVendedor?.distance ?? 0.0);
  }

  PedidoDto toDto() {
    return PedidoDto(
      BaseDto(id),
      lat,
      lng,
      distance,
      userVendedor,
      userConsumidor.toDto(),
      dataHoraCriado,
      dataHoraFinalizado,
      statusPedido,
      itensPedido,
    );
  }

  PedidoStore clone() {
    return PedidoStore(
      this.id,
      this.lat,
      this.lng,
      this.distance,
      this.userConsumidor,
      this.userVendedor,
      this.itensPedido,
      this.dataHoraCriado,
      this.dataHoraFinalizado,
      this.statusPedido,
    );
  }

  _PedidoStore(
    this.id,
    this.lat,
    this.lng,
    this.distance,
    this.userConsumidor,
    this.userVendedor,
    this.itensPedido,
    this.dataHoraCriado,
    this.dataHoraFinalizado,
    this.statusPedido,
  );
}

abstract class PedidoStoreFactory {
  static PedidoStore fromDto(PedidoDto dto) {
    if (dto != null) {
      return PedidoStore(
        dto.base.id,
        dto.lat,
        dto.lng,
        dto.distance,
        UserStoreFactory.fromDto(dto.userConsumidor),
        dto.userVendedor,
        dto.itensPedido,
        dto.dataHoraCriado,
        dto.dataHoraFinalizado,
        dto.statusPedido,
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
      null,
      null,
    );
  }
}
