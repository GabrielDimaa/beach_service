import 'package:beach_service/app/modules/produto/dtos/produto_dto.dart';
import 'package:beach_service/app/modules/user/dtos/user_prod_dto.dart';
import 'package:beach_service/app/shared/dtos/base_dto.dart';
import 'package:mobx/mobx.dart';

part 'user_prod_store.g.dart';

class UserProdStore = _UserProdStore with _$UserProdStore;

abstract class _UserProdStore with Store {
  @observable
  int id;

  @observable
  String nome;

  @observable
  String email;

  @observable
  String telefone;

  @observable
  String empresa;

  @observable
  double lat;

  @observable
  double lng;

  @observable
  double distance;

  @observable
  List<ProdutoDto> produtos = ObservableList<ProdutoDto>();

  @action
  void setId(int value) => id = value;

  @action
  void setNome(String value) => nome = value;

  @action
  void setEmail(String value) => email = value;

  @action
  void setTelefone(String value) => telefone = value;

  @action
  void setEmpresa(String value) => empresa = value;

  @action
  void setLat(double value) => lat = value;

  @action
  void setLng(double value) => lng = value;

  @action
  void setDistance(double value) => distance = value;

  @action
  void setProdutos(List<ProdutoDto> values) {
    produtos = ObservableList<ProdutoDto>();
    produtos.addAll(values);
  }

  _UserProdStore({
    this.id,
    this.nome,
    this.email,
    this.telefone,
    this.empresa,
    this.lat,
    this.lng,
    this.distance,
    this.produtos,
  });

  UserProdDto toDto() {
    return UserProdDto(
      base: BaseDto(id),
      nome: nome,
      email: email,
      telefone: telefone,
      empresa: empresa,
      lat: lat,
      lng: lng,
      distance: distance,
      produtos: produtos,
    );
  }
}

abstract class UserProdStoreFactory {
  static UserProdStore fromDto(UserProdDto dto) {
    if (dto != null) {
      return UserProdStore(
        id: dto.base.id,
        nome: dto.nome,
        email: dto.email,
        telefone: dto.telefone,
        empresa: dto.empresa,
        lat: dto.lat,
        lng: dto.lng,
        distance: dto.distance,
        produtos: dto.produtos,
      );
    } else {
      return null;
    }
  }
}
