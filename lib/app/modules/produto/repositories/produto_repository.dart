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
  String getRoute() => "${Api.baseURL}/produtos";

  Dio dio = Dio();

  @override
  Map<String, dynamic> toMap(ProdutoDto dto) {
    return {
      'id_produto': dto.base.id,
      'id_user': 0
    };
  }

  @override
  ProdutoDto fromMap(Map<String, dynamic> e) {
    return ProdutoDto(
      BaseDto(e['id']),
      e['descricao'],
      CategoriaDto(
        BaseDto(e['categorias']['id']),
        e['categorias']['descricao'],
      ),
    );
  }

  @override
  Future<List<ProdutoDto>> saveOrUpdate(List<ProdutoDto> listDto, UserDto userDto) async {
    if (listDto.isEmpty) throw Exception("Nem um produto selecionado!");

    List<Map<String, dynamic>> data = [
      for(ProdutoDto it in listDto) {'${it.base.id}': '${userDto.base.id}'}
    ];

    List response = (await dio.post(getRoute(), data: data)).data;

    if (response.isNotEmpty)
      return listDto;
    else
      return null;
  }

  @override
  void validate(ProdutoDto dto) {}
}
