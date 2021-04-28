import 'package:beach_service/app/modules/produto/services/produto_service_interface.dart';
import 'package:beach_service/app/modules/produto/stores/produto_store.dart';
import 'package:beach_service/app/shared/interfaces/form_controller_interface.dart';
import 'package:mobx/mobx.dart';

part 'produto_controller.g.dart';

class ProdutoController = _ProdutoControllerBase with _$ProdutoController;

abstract class _ProdutoControllerBase with Store implements IFormController {
  final IProdutoService produtoService;

  _ProdutoControllerBase(this.produtoService);

  @observable
  ProdutoStore produtoStore;

  @observable
  bool loading = false;

  @action
  void setLoading(bool value) => loading = value;

  @action
  Future<void> load() async {}

  @override
  Future<void> save() {}

  @override
  Future<void> delete() {}
}