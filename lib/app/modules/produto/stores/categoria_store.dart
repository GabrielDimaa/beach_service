import 'package:beach_service/app/modules/produto/dtos/categoria_dto.dart';
import 'package:beach_service/app/shared/dtos/base_dto.dart';
import 'package:mobx/mobx.dart';

part 'categoria_store.g.dart';

class CategoriaStore = _CategoriaStoreBase with _$CategoriaStore;

abstract class _CategoriaStoreBase with Store {
  int id;

  @observable
  String descricao;

  @action
  void setDescricao(String value) => descricao = value;

  _CategoriaStoreBase({this.id, this.descricao});

  CategoriaDto toDto() {
    return CategoriaDto(BaseDto(id), descricao);
  }
}

abstract class CategoriaStoreFactory {
  static CategoriaStore fromDto(CategoriaDto dto) {
    if (dto != null) {
      return CategoriaStore(
        id: dto.base.id,
        descricao: dto.descricao,
      );
    } else {
      return null;
    }
  }

  static CategoriaStore novo() {
    return CategoriaStore(
      id: null,
      descricao: null,
    );
  }
}