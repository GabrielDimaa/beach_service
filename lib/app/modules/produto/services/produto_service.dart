import 'package:beach_service/app/modules/produto/dtos/produto_dto.dart';
import 'package:beach_service/app/modules/produto/repositories/produto_repository_interface.dart';
import 'package:beach_service/app/modules/produto/services/produto_service_interface.dart';
import 'package:beach_service/app/shared/services/base_service.dart';

class ProdutoService extends BaseService<ProdutoDto, IProdutoRepository> implements IProdutoService {
  ProdutoService(IProdutoRepository baseRepository) : super(baseRepository);
}