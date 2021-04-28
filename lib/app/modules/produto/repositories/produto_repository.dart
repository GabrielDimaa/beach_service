import 'package:beach_service/app/modules/produto/dtos/produto_dto.dart';
import 'package:beach_service/app/modules/produto/repositories/produto_repository_interface.dart';
import 'package:beach_service/app/shared/repositories/base_repository.dart';

class ProdutoRepository extends BaseRepository<ProdutoDto> implements IProdutoRepository {
  @override
  String getRoute() {
    // TODO: implement getRoute
    throw UnimplementedError();
  }

  @override
  void validate(ProdutoDto dto) {
    // TODO: implement validate
  }

  @override
  Map<String, dynamic> toMap(ProdutoDto dto) {
    // TODO: implement toMap
    throw UnimplementedError();
  }

  @override
  ProdutoDto fromMap(Map<String, dynamic> e) {
    // TODO: implement fromMap
    throw UnimplementedError();
  }
}
