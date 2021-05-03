import 'package:beach_service/app/modules/produto/dtos/produto_dto.dart';
import 'package:beach_service/app/modules/produto/stores/categoria_store.dart';
import 'package:beach_service/app/shared/dtos/base_dto.dart';
import 'package:mobx/mobx.dart';

part 'produto_store.g.dart';

class ProdutoStore = _ProdutoStoreBase with _$ProdutoStore;

abstract class _ProdutoStoreBase with Store {
  int id;

  @observable
  String descricao;

  @observable
  CategoriaStore categoriaStore = CategoriaStore();

  @action
  void setNome(String value) => descricao = value;

  _ProdutoStoreBase({this.id, this.descricao, this.categoriaStore});

  ProdutoDto toDto() {
    return ProdutoDto(BaseDto(id), descricao, categoriaStore.toDto());
  }
}

abstract class ProdutoStoreFactory {
  static ProdutoStore fromDto(ProdutoDto dto) {
    if (dto != null) {
      return ProdutoStore(
        id: dto.base.id,
        descricao: dto.descricao,
        categoriaStore: CategoriaStoreFactory.fromDto(dto.categoriaDto),
      );
    } else {
      return null;
    }
  }

  static ProdutoStore novo() {
    return ProdutoStore(
      id: null,
      descricao: null,
      categoriaStore: CategoriaStoreFactory.novo(),
    );
  }
}