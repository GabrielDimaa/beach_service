import 'package:beach_service/app/app_controller.dart';
import 'package:beach_service/app/modules/home/services/sincronizacao_service_interface.dart';
import 'package:beach_service/app/modules/pedido/pages/pedido_controller.dart';
import 'package:beach_service/app/modules/produto/dtos/categoria_dto.dart';
import 'package:beach_service/app/modules/produto/dtos/produto_dto.dart';
import 'package:beach_service/app/modules/produto/services/produto_service_interface.dart';
import 'package:beach_service/app/modules/produto/stores/produto_store.dart';
import 'package:beach_service/app/modules/user/dtos/user_dto.dart';
import 'package:beach_service/app/modules/user/services/user_service_interface.dart';
import 'package:beach_service/app/modules/user/pages/cadastro/user_cadastro_controller.dart';
import 'package:beach_service/app/shared/components/dialog/alert_dialog_widget.dart';
import 'package:beach_service/app/shared/constants/page.dart';
import 'package:beach_service/app/shared/dtos/base_dto.dart';
import 'package:beach_service/app/shared/interfaces/form_controller_interface.dart';
import 'package:beach_service/app/shared/routes/routes.dart';
import 'package:diacritic/diacritic.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'produto_controller.g.dart';

class ProdutoController = _ProdutoControllerBase with _$ProdutoController;

abstract class _ProdutoControllerBase with Store implements IFormController {
  final IProdutoService produtoService;
  final IUserService userService;
  final UserCadastroController userController;
  final PedidoController pedidoController;
  final AppController appController;
  final ISincronizacaoService sincronizacaoService;

  _ProdutoControllerBase(
    this.produtoService,
    this.userService,
    this.userController,
    this.pedidoController,
    this.appController,
    this.sincronizacaoService,
  );

  CategoriaDto categoriaTodos = CategoriaDto(BaseDto(0), "Todos");

  @observable
  int pageController = 0;

  @observable
  ProdutoStore produtoStore = ProdutoStore();

  @observable
  List<ProdutoDto> produtosAll = ObservableList<ProdutoDto>();

  @observable
  List<ProdutoDto> produtosFiltrados = ObservableList<ProdutoDto>();

  @observable
  List<ProdutoDto> produtosSelect = ObservableList<ProdutoDto>();

  @observable
  List<CategoriaDto> categoriasAll = ObservableList<CategoriaDto>();

  @observable
  CategoriaDto categoriaFiltro;

  @observable
  bool loading = false;

  @observable
  BuildContext context;

  @action
  void setPageController(int value) => pageController = value;

  @action
  void setLoading(bool value) => loading = value;

  @action
  void setContext(BuildContext value) => context = value;

  @action
  Future<void> load() async {
    try {
      loading = true;

      if ((pedidoController.pedidoStore?.userVendedor?.produtos?.length ?? 0) > 0) {
        produtosAll.addAll(pedidoController.pedidoStore.userVendedor.produtos);

        produtosSelect.addAll(pedidoController.pedidoStore.itensPedido ?? []);
      } else {
        produtosAll = await produtoService.getAll().asObservable();
        if (appController.userStore.isVendedor) await _getSelecionados();
      }

      _getCategorias();
    } catch (e) {
      AlertDialogWidget(content: "$e");
    } finally {
      loading = false;
    }
  }

  @override
  Future<void> save() async {
    try {
      setLoading(true);

      if (produtosSelect.isEmpty) throw Exception("Selecione ao menos um produto!");

      List<ProdutoDto> listProdDto = [];

      if (userController?.primeiroRegistro ?? false) {
            UserDto userDto = userController.userStore.toDto();
            userDto = await userService.saveOrUpdate(userDto);

            if (userDto.base.id != null) listProdDto = await produtoService.saveProdutos(produtosSelect, userDto);

            if (listProdDto.isNotEmpty) Modular.to.navigate(Modular.initialRoute);
          } else {
            sincronizacaoService.stop();
            listProdDto = await produtoService.saveProdutos(produtosSelect, appController.userStore.toDto());
            sincronizacaoService.start();

            AlertDialogWidget.show(context, content: "Seus produtos foram salvos!");

            Future.delayed(Duration(milliseconds: 400), () {
              appController.page = HOME_PAGE;
              Modular.to.navigate("/$HOME_ROUTE");
            });
          }
    } catch (e) {
      rethrow;
    } finally {
      setLoading(false);
    }
  }

  @action
  Future<void> delete() async {}

  @action
  Future<void> avancarPedido() async {
    pedidoController.pedidoStore.itensPedido = [];
    pedidoController.pedidoStore.itensPedido.addAll(produtosSelect);

    Modular.to.pop();
  }

  @computed
  bool get isPedido => pedidoController?.pedidoStore?.userVendedor != null;

  @computed
  bool get isDrawer => isPedido || (userController?.primeiroRegistro ?? false);

  @action
  void setProdutosSelect(ProdutoDto value) => produtosSelect.add(value);

  @action
  void removeProdutosSelect(ProdutoDto value) {
    if (isSelect(value)) produtosSelect.remove(value);
  }

  @action
  void setCategoriaFiltro(CategoriaDto value) {
    categoriaFiltro = value;
    _filtrar();
  }

  @action
  void _getCategorias() {
    List<CategoriaDto> categorias = [];
    categoriasAll = [];

    produtosAll.forEach((e) {
      if (!categorias.any((element) => element.base.id == e.categoriaDto.base.id)) categorias.add(e.categoriaDto);
    });

    categorias.sort((a, b) => removeDiacritics(a.descricao?.toLowerCase()).compareTo(b.descricao?.toLowerCase()));

    categoriasAll.add(categoriaTodos);

    categoriasAll.addAll(categorias.asObservable());
    setCategoriaFiltro(categoriasAll[0]);
  }

  @action
  void _filtrar() {
    List<ProdutoDto> produtos = [];
    produtosFiltrados = [];

    //Se a categoria que está sendo filtrada for "Todos" recebe todos os produtos
    //Senão filtra no produtosAll o produto que tem a categoria
    if (categoriaFiltro.base.id == categoriaTodos.base.id)
      produtos = produtosAll;
    else
      produtos = produtosAll.where((element) => element.categoriaDto.base.id == categoriaFiltro.base.id).toList().asObservable();

    produtos.sort((a, b) => removeDiacritics(a.descricao?.toLowerCase()).compareTo(b.descricao?.toLowerCase()));

    produtosFiltrados.addAll(produtos.asObservable());
  }

  bool isSelect(ProdutoDto value) {
    return produtosSelect.any((element) => element.base.id == value.base.id);
  }

  Future<void> _getSelecionados() async {
    List<ProdutoDto> lista = await produtoService.getProdutosById(appController.userStore.id);

    produtosAll.forEach((element) {
      if (lista.any((e) => e.base.id == element.base.id)) setProdutosSelect(element);
    });
  }
}
