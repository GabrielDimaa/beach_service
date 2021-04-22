import 'package:beach_service/app/modules/user/enums/enum_tipo_user.dart';

class UserDto {
  int id;
  String nome;
  String email;
  String password;
  String cep;
  String telefone;
  DateTime dataNascimento;
  EnumTipoUser tipoUser;

  UserDto(
    this.id,
    this.nome,
    this.email,
    this.password,
    this.cep,
    this.telefone,
    this.dataNascimento,
    this.tipoUser,
  );
}
