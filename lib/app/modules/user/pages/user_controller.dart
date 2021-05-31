import 'package:beach_service/app/modules/home/home_controller.dart';
import 'package:beach_service/app/modules/produto/dtos/categoria_dto.dart';
import 'package:beach_service/app/modules/produto/dtos/produto_dto.dart';
import 'package:beach_service/app/modules/produto/services/produto_service_interface.dart';
import 'package:beach_service/app/modules/user/dtos/user_dto.dart';
import 'package:beach_service/app/modules/user/dtos/user_prod_dto.dart';
import 'package:beach_service/app/modules/user/services/user_service_interface.dart';
import 'package:beach_service/app/modules/user/stores/user_prod_store.dart';
import 'package:beach_service/app/shared/utils/produtos_utils.dart';
import 'package:diacritic/diacritic.dart';
import 'package:mobx/mobx.dart';

part 'user_controller.g.dart';

class UserController = _UserController with _$UserController;

abstract class _UserController with Store {
  final HomeController homeController;
  final IUserService userService;
  final IProdutoService produtoService;

  _UserController(this.homeController, this.userService, this.produtoService);

  @observable
  UserProdStore userProdStore = UserProdStore();

  @observable
  List<CategoriaDto> categorias = ObservableList<CategoriaDto>();

  @observable
  bool loading;

  @action
  void setLoading(bool value) => loading = value;

  Future<void> load(UserProdDto dto) async {
    try {
      setLoading(true);

      if (dto != null) {
        userProdStore = UserProdStoreFactory.fromDto(dto);

        userProdStore.produtos.sort((a, b) => removeDiacritics(a.descricao?.toLowerCase()).compareTo(b.descricao?.toLowerCase()));
        categorias.addAll(ProdutosUtils.getCategorias(dto.produtos));
      } else {
        if (homeController.userStore.isVendedor) {
          UserDto userDto = await userService.getById(homeController.userStore.id);
          List<ProdutoDto> produtos = await produtoService.getProdutosById(userDto.base.id);

          userProdStore = UserProdStoreFactory.fromDto(userDto.toUserProdDto());
          userProdStore.produtos.addAll(produtos);

          userProdStore.produtos.sort((a, b) => removeDiacritics(a.descricao?.toLowerCase()).compareTo(b.descricao?.toLowerCase()));
          categorias.addAll(ProdutosUtils.getCategorias(userProdStore.produtos));
        } else {
          userProdStore = UserProdStoreFactory.fromDto(homeController.userStore.toDto().toUserProdDto());
        }
      }
    } catch(e) {
      rethrow;
    } finally {
      setLoading(false);
    }
  }
}