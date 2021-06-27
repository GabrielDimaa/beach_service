import 'package:beach_service/app/modules/produto/dtos/categoria_dto.dart';
import 'package:beach_service/app/modules/produto/dtos/produto_dto.dart';
import 'package:beach_service/app/modules/produto/repositories/produto_repository_interface.dart';
import 'package:beach_service/app/modules/user/dtos/user_dto.dart';
import 'package:beach_service/app/shared/api/api.dart';
import 'package:beach_service/app/shared/dtos/base_dto.dart';
import 'package:beach_service/app/shared/repositories/base_repository.dart';
import 'package:dio/dio.dart';

class ProdutoRepository extends BaseRepository<ProdutoDto> implements IProdutoRepository {
  @override
  String getRoute() => "${BaseURL.baseURL}/produtos";

  static Api api = Api();

  @override
  Map<String, dynamic> toMap(ProdutoDto dto) {
    throw UnimplementedError();
  }

  @override
  ProdutoDto fromMap(Map<String, dynamic> e) {
    return ProdutoDto(
      BaseDto(e['id']),
      e['descricao'],
      CategoriaDto(
        BaseDto(e['categoria']['id']),
        e['categoria']['descricao'],
      ),
    );
  }

  @override
  Future<List<ProdutoDto>> saveOrUpdate(List<ProdutoDto> listDto, UserDto userDto) async {
    if (listDto.isEmpty) throw Exception("Nenhum produto selecionado!");

    Map<String, dynamic> data = {"produtos": [
      for(ProdutoDto it in listDto) {
        'produto_id': '${it.base.id}',
        'user_id': '${userDto.base.id}'
      }
    ]};

    List response = (await api.post(getRoute(), data: data)).data;

    if (response.isNotEmpty)
      return listDto;
    else
      return null;
  }

  @override
  Future<List<ProdutoDto>> getProdutosById(int id) async {
    try {
      if (id == null) throw Exception("Não encontrado!");

      List<ProdutoDto> produtos = [];

      dynamic response = await api.get("${getRoute()}/$id");

      if (response != null) {
        (response.data as List).forEach((element) {
          produtos.add(fromMap(element));
        });
      }

      return produtos;
    } on DioError catch(e) {
      if (e.response != null) throw Exception(e.response.data[0]['message']);
      throw Exception(e);
    } catch(e) {
      throw Exception(e);
    }
  }

  @override
  void validate(ProdutoDto dto) {}
}
