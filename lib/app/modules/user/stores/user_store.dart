import 'package:beach_service/app/modules/user/dtos/user_dto.dart';
import 'package:beach_service/app/modules/user/enums/enum_tipo_user.dart';
import 'package:beach_service/app/shared/dtos/base_dto.dart';
import 'package:mobx/mobx.dart';

part 'user_store.g.dart';

class UserStore = _UserStoreBase with _$UserStore;

abstract class _UserStoreBase with Store {
  int id;

  @observable
  String nome;

  @observable
  String email;

  @observable
  String password;

  @observable
  String cep;

  @observable
  String telefone;

  @observable
  DateTime dataNascimento;

  @observable
  EnumTipoUser tipoUser;

  @observable
  String empresa;

  @action
  void setNome(String value) => nome = value;

  @action
  void setEmail(String value) => email = value;

  @action
  void setPassword(String value) => password = value;

  @action
  void setCep(String value) => cep = value;

  @action
  void setTelefone(String value) => telefone = value;

  @action
  void setDataNascimento(DateTime value) => dataNascimento = value;

  @action
  void setTipoUser(EnumTipoUser value) => tipoUser = value;

  @action
  void setEmpresa(String value) => empresa = value;

  @computed
  bool get userIsNotNull => tipoUser != null;

  @computed
  bool get isConsumidor => userIsNotNull && tipoUser == EnumTipoUser.Consumidor;

  @computed
  bool get isVendedor => userIsNotNull && tipoUser == EnumTipoUser.Vendedor;

  _UserStoreBase({
    this.id,
    this.nome,
    this.email,
    this.password,
    this.cep,
    this.telefone,
    this.dataNascimento,
    this.tipoUser,
    this.empresa,
  });

  UserDto toDto() {
    return UserDto(
      BaseDto(id),
      nome,
      email,
      password,
      cep,
      telefone,
      dataNascimento,
      tipoUser,
      empresa,
    );
  }

  void fromDto(UserDto dto) {
    if (dto != null) {
      this.id = dto.base.id;
      this.nome = dto.nome;
      this.email = dto.email;
      this.password = dto.password;
      this.cep = dto.cep;
      this.telefone = dto.telefone;
      this.dataNascimento = dto.dataNascimento;
      this.tipoUser = dto.tipoUser;
      this.empresa = dto.empresa;
    }
  }
}
