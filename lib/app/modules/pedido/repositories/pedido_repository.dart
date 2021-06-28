import 'package:beach_service/app/modules/pedido/dtos/pedido_dto.dart';
import 'package:beach_service/app/modules/pedido/repositories/pedido_repository_interface.dart';
import 'package:beach_service/app/modules/produto/dtos/produto_dto.dart';
import 'package:beach_service/app/modules/produto/repositories/produto_repository.dart';
import 'package:beach_service/app/modules/user/repositories/user_repository.dart';
import 'package:beach_service/app/shared/api/api.dart';
import 'package:beach_service/app/shared/dtos/base_dto.dart';
import 'package:beach_service/app/shared/repositories/base_repository.dart';
import 'package:beach_service/app/shared/extensions/string_extension.dart';

class PedidoRepository extends BaseRepository<PedidoDto> implements IPedidoRepository {
  @override
  String getRoute() => "${BaseURL.baseURL}/pedido";

  static Api api = Api();

  @override
  void validate(PedidoDto dto) {
    if (dto.userVendedor?.base?.id == null) throw Exception("Houve um erro ao concluir seu pedido.");
    if (dto.lng == null || dto.lng == null) throw Exception("Houve um erro ao buscar sua localização.");
    if (dto.itensPedido == null || dto.itensPedido.isEmpty) throw Exception("Escolha ao menos um produto.");
  }

  @override
  Map<String, dynamic> toMap(PedidoDto dto) {
    List<Map<String, dynamic>> itens = [];
    dto.itensPedido.forEach((e) => itens.add({'produto_id': e.base.id}));

    return {
      'id': dto.base?.id,
      'lat': dto.lat,
      'lng': dto.lng,
      'id_consumidor': dto.userConsumidor.base.id,
      'id_vendedor': dto.userVendedor.base.id,
      'itens': itens,
    };
  }

  @override
  PedidoDto fromMap(Map<String, dynamic> e) {
    List<dynamic> produtosMap = [];
    List<ProdutoDto> produtos = [];

    if (e.containsKey('itens'))
      produtosMap = e['itens'];

    if (produtosMap != null && produtosMap.isNotEmpty) produtosMap.forEach((element) {
      produtos.add(ProdutoRepository().fromMap(element));
    });

    return PedidoDto(
      BaseDto(e['id']),
      e['lat'],
      e['lng'],
      e.containsKey('user_vendedor') ? UserRepository().fromMapUserProd(e['user_vendedor']) : null,
      e.containsKey('user_consumidor') ? UserRepository().fromMap(e['user_consumidor']) : null,
      e['data_hora_criado'].toString().parseToDateTimeWithHour(),
      e['data_hora_finalizado']?.toString()?.parseToDateTimeWithHour(),
      produtos,
    );
  }
}
