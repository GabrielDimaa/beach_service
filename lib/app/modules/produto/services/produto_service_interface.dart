import 'package:beach_service/app/modules/produto/dtos/produto_dto.dart';
import 'package:beach_service/app/modules/user/dtos/user_dto.dart';
import 'package:beach_service/app/shared/services/base_service_interface.dart';

abstract class IProdutoService implements IBaseService<ProdutoDto> {
  Future<List<ProdutoDto>> saveProdutos(List<ProdutoDto> listDto, UserDto userDto);
  Future<List<ProdutoDto>> getProdutosById(int id);
}