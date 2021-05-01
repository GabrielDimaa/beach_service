import 'package:beach_service/app/modules/produto/dtos/categoria_dto.dart';
import 'package:beach_service/app/modules/produto/dtos/produto_dto.dart';
import 'package:beach_service/app/modules/produto/services/produto_service_interface.dart';
import 'package:beach_service/app/modules/produto/stores/produto_store.dart';
import 'package:beach_service/app/shared/components/dialog/alert_dialog_widget.dart';
import 'package:beach_service/app/shared/dtos/base_dto.dart';
import 'package:beach_service/app/shared/interfaces/form_controller_interface.dart';
import 'package:diacritic/diacritic.dart';
import 'package:mobx/mobx.dart';

part 'produto_controller.g.dart';

class ProdutoController = _ProdutoControllerBase with _$ProdutoController;

abstract class _ProdutoControllerBase with Store implements IFormController {
  final IProdutoService produtoService;

  _ProdutoControllerBase(this.produtoService);

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

  @action
  void setPageController(int value) => pageController = value;

  @action
  void setLoading(bool value) => loading = value;

  @action
  Future<void> load() async {
    try {
      loading = true;

      produtosAll = await produtoService.getAll().asObservable();

      _getCategorias();
    } catch (e) {
      AlertDialogWidget(content: "$e");
    } finally {
      loading = false;
    }
  }

  @action
  Future<void> save() async {

  }

  @action
  Future<void> delete() async {}

  @action
  void setProdutosSelect(ProdutoDto value) => produtosSelect.add(value);

  @action
  void removeProdutosSelect(ProdutoDto value) {
    if (isSelect(value))
      produtosSelect.remove(value);
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
}
