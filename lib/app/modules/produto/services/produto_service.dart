import 'package:beach_service/app/modules/produto/dtos/produto_dto.dart';
import 'package:beach_service/app/modules/produto/repositories/produto_repository_interface.dart';
import 'package:beach_service/app/modules/produto/services/produto_service_interface.dart';
import 'package:beach_service/app/shared/services/base_service.dart';

class ProdutoService extends BaseService<ProdutoDto, IProdutoRepository> implements IProdutoService {
  ProdutoService(IProdutoRepository baseRepository) : super(baseRepository);
}

// List<ProdutoDto> produtos1 =
// List.generate(10, (index) => ProdutoDto(BaseDto(index), "Comida ${index + 1}", CategoriaDto(BaseDto(1), "Comida")));
// List<ProdutoDto> produtos2 =
// List.generate(10, (index) => ProdutoDto(BaseDto(index + 10), "Bazar ${index}", CategoriaDto(BaseDto(2), "Bazar")));
// List<ProdutoDto> produtos3 =
// List.generate(10, (index) => ProdutoDto(BaseDto(index + 20), "Bebidas ${index}", CategoriaDto(BaseDto(3), "Bebidas")));
//
// List<ProdutoDto> lista = [];
// lista.addAll(produtos1);
// lista.addAll(produtos2);
// lista.addAll(produtos3);
//
// return lista;