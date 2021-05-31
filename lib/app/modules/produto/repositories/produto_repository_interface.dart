import 'package:beach_service/app/modules/produto/dtos/produto_dto.dart';
import 'package:beach_service/app/modules/user/dtos/user_dto.dart';
import 'package:beach_service/app/shared/repositories/base_repository_interface.dart';

abstract class IProdutoRepository implements IBaseRepository<ProdutoDto> {
  Future<List<ProdutoDto>> saveOrUpdate(List<ProdutoDto> listDto, UserDto userDto);
  Future<List<ProdutoDto>> getProdutosById(int id);
}