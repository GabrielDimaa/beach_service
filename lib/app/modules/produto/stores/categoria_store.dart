import 'package:beach_service/app/modules/produto/dtos/categoria_dto.dart';
import 'package:beach_service/app/shared/dtos/base_dto.dart';
import 'package:mobx/mobx.dart';

part 'categoria_store.g.dart';

class CategoriaStore = _CategoriaStoreBase with _$CategoriaStore;

abstract class _CategoriaStoreBase with Store {
  int id;

  @observable
  String nome;

  @action
  void setNome(String value) => nome = value;

  _CategoriaStoreBase(this.id, this.nome);

  CategoriaDto toDto() {
    return CategoriaDto(BaseDto(id), nome);
  }
}

abstract class CategoriaStoreFactory {
  static CategoriaStore fromDto(CategoriaDto dto) {
    if (dto != null) {
      return CategoriaStore(
        dto.base.id,
        dto.nome,
      );
    }
  }
}