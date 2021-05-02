import 'package:beach_service/app/modules/user/enums/enum_tipo_user.dart';
import 'package:beach_service/app/shared/dtos/base_dto.dart';
import 'package:beach_service/app/shared/dtos/base_dto_interface.dart';

class UserDto implements IBaseDto {
  @override
  BaseDto base;

  String nome;
  String email;
  String password;
  String cep;
  String telefone;
  DateTime dataNascimento;
  EnumTipoUser tipoUser;
  String empresa;

  UserDto(
    this.base,
    this.nome,
    this.email,
    this.cep,
    this.telefone,
    this.dataNascimento,
    this.tipoUser,
    this.empresa,
    {this.password}
  );
}
