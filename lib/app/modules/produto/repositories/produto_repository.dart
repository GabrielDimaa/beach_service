import 'package:beach_service/app/modules/produto/dtos/categoria_dto.dart';
import 'package:beach_service/app/modules/produto/dtos/produto_dto.dart';
import 'package:beach_service/app/modules/produto/repositories/produto_repository_interface.dart';
import 'package:beach_service/app/shared/api/api.dart';
import 'package:beach_service/app/shared/dtos/base_dto.dart';
import 'package:beach_service/app/shared/repositories/base_repository.dart';

class ProdutoRepository extends BaseRepository<ProdutoDto> implements IProdutoRepository {
  @override
  String getRoute() => "${Api.baseURL}/produtos";

  @override
  void validate(ProdutoDto dto) {

  }

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
}
