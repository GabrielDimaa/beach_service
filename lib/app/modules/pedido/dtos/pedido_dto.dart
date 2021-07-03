import 'package:beach_service/app/modules/pedido/enums/enum_status_pedido.dart';
import 'package:beach_service/app/modules/produto/dtos/produto_dto.dart';
import 'package:beach_service/app/modules/user/dtos/user_dto.dart';
import 'package:beach_service/app/modules/user/dtos/user_prod_dto.dart';
import 'package:beach_service/app/shared/dtos/base_dto.dart';
import 'package:beach_service/app/shared/dtos/base_dto_interface.dart';

class PedidoDto implements IBaseDto {
  @override
  BaseDto base;

  double lat;
  double lng;
  double distance;

  UserProdDto userVendedor;
  UserDto userConsumidor;

  DateTime dataHoraCriado;
  DateTime dataHoraFinalizado;

  EnumStatusPedido statusPedido;

  List<ProdutoDto> itensPedido;

  PedidoDto(
    this.base,
    this.lat,
    this.lng,
    this.distance,
    this.userVendedor,
    this.userConsumidor,
    this.dataHoraCriado,
    this.dataHoraFinalizado,
    this.statusPedido,
    this.itensPedido,
  );
}
