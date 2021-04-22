import 'package:beach_service/app/modules/user/dtos/user_dto.dart';
import 'package:beach_service/app/modules/user/enums/enum_tipo_user.dart';
import 'package:mobx/mobx.dart';

part 'user_store.g.dart';

class UserStore = UserStoreBase with _$UserStore;

abstract class UserStoreBase with Store {
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

  @action
  void setNome(String value) => nome = value;

  @action
  void setEmail(String value) => email = value;

  @action
  void setPassword(String value) => password = value;

  @action
  void setTelefone(String value) => telefone = value;

  @action
  void setDataNascimento(DateTime value) => dataNascimento = value;

  @action
  void setIsVendedor(EnumTipoUser value) => tipoUser = value;

  UserStoreBase({
    this.id,
    this.nome,
    this.email,
    this.password,
    this.cep,
    this.telefone,
    this.dataNascimento,
    this.tipoUser,
  });

  UserDto toDto() {
    return UserDto(
      id,
      nome,
      email,
      password,
      cep,
      telefone,
      dataNascimento,
      tipoUser,
    );
  }

  void fromDto(UserDto dto) {
    if (dto != null) {
      this.id = dto.id;
      this.nome = dto.nome;
      this.email = dto.email;
      this.password = dto.password;
      this.cep = dto.cep;
      this.telefone = dto.telefone;
      this.dataNascimento = dto.dataNascimento;
      this.tipoUser = dto.tipoUser;
    }
  }
}
