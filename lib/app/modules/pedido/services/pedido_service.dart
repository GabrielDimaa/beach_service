import 'package:beach_service/app/modules/pedido/dtos/pedido_dto.dart';
import 'package:beach_service/app/modules/pedido/repositories/pedido_repository_interface.dart';
import 'package:beach_service/app/modules/pedido/services/pedido_service_interface.dart';
import 'package:beach_service/app/shared/services/base_service.dart';

class PedidoService extends BaseService<PedidoDto, IPedidoRepository> implements IPedidoService {
  PedidoService(IPedidoRepository baseRepository) : super(baseRepository);
}