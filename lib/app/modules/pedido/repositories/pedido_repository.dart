import 'package:beach_service/app/modules/pedido/dtos/pedido_dto.dart';
import 'package:beach_service/app/modules/pedido/repositories/pedido_repository_interface.dart';
import 'package:beach_service/app/shared/api/api.dart';
import 'package:beach_service/app/shared/repositories/base_repository.dart';

class PedidoRepository extends BaseRepository<PedidoDto> implements IPedidoRepository {
  @override
  String getRoute() => "${BaseURL.baseURL}/pedidos";

  static Api api = Api();

  @override
  void validate(PedidoDto dto) {}

  @override
  Map<String, dynamic> toMap(PedidoDto dto) {}

  @override
  PedidoDto fromMap(Map<String, dynamic> e) {}
}