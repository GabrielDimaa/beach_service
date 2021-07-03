import 'package:beach_service/app/modules/pedido/dtos/pedido_dto.dart';
import 'package:beach_service/app/modules/pedido/enums/enum_status_pedido.dart';
import 'package:beach_service/app/modules/pedido/repositories/pedido_repository_interface.dart';
import 'package:beach_service/app/modules/produto/dtos/produto_dto.dart';
import 'package:beach_service/app/modules/produto/repositories/produto_repository.dart';
import 'package:beach_service/app/modules/user/dtos/user_dto.dart';
import 'package:beach_service/app/modules/user/dtos/user_prod_dto.dart';
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
      'status': EnumStatusPedidoHelper.getValue(dto.statusPedido),
      'distance': dto.distance,
      'produtos': itens,
    };
  }

  @override
  PedidoDto fromMap(Map<String, dynamic> e) {
    List<dynamic> produtosMap = [];
    List<ProdutoDto> produtos = [];

    if (e.containsKey('produtos')) produtosMap = e['produtos'];

    if (produtosMap != null && produtosMap.isNotEmpty)
      produtosMap.forEach((element) {
        produtos.add(ProdutoRepository().fromMap(element));
      });

    return PedidoDto(
      BaseDto(e['id']),
      e['lat'],
      e['lng'],
      double.parse(e['distance'].toString()),
      e.containsKey('user_vendedor')
          ? UserProdDto(
              base: BaseDto(e['user_vendedor']['id']),
              nome: e['user_vendedor']['nome'],
              email: e['user_vendedor']['email'],
              telefone: e['user_vendedor']['telefone'],
              empresa: e['user_vendedor']['empresa'],
            )
          : null,
      e.containsKey('user_consumidor')
          ? UserDto(
              BaseDto(e['user_consumidor']['id']),
              e['user_consumidor']['nome'],
              e['user_consumidor']['email'],
              null,
              e['user_consumidor']['telefone'],
              null,
              null,
              null,
              null,
              null,
              null,
            )
          : null,
      e['data_hora_criado'].toString().parseToDateTimeWithHour(),
      e['data_hora_finalizado']?.toString()?.parseToDateTimeWithHour(),
      EnumStatusPedidoHelper.get(int.parse(e['status'].toString())),
      produtos,
    );
  }

  @override
  Future<List<PedidoDto>> getAll({params}) {
    Map<String, dynamic> json = {};
    if (params != null) json = {'id': params};

    return super.getAll(params: json);
  }
}
