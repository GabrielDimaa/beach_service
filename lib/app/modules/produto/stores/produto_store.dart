import 'package:beach_service/app/modules/produto/dtos/produto_dto.dart';
import 'package:beach_service/app/modules/produto/stores/categoria_store.dart';
import 'package:beach_service/app/shared/dtos/base_dto.dart';
import 'package:mobx/mobx.dart';

part 'produto_store.g.dart';

class ProdutoStore = _ProdutoStoreBase with _$ProdutoStore;

abstract class _ProdutoStoreBase with Store {
  int id;

  @observable
  String nome;

  @observable
  CategoriaStore categoriaStore;

  @action
  void setNome(String value) => nome = value;

  _ProdutoStoreBase(this.id, this.nome, this.categoriaStore);

  ProdutoDto toDto() {
    return ProdutoDto(BaseDto(id), nome, categoriaStore.toDto());
  }
}

abstract class ProdutoStoreFactory {
  static ProdutoStore fromDto(ProdutoDto dto) {
    if (dto != null) {
      return ProdutoStore(
          dto.base.id,
          dto.nome,
          CategoriaStoreFactory.fromDto(dto.categoriaDto),
      );
    }
  }
}