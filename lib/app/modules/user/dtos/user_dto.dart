import 'package:beach_service/app/modules/user/dtos/user_prod_dto.dart';
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
  double lat;
  double lng;
  bool isOnline;

  UserDto(
    this.base,
    this.nome,
    this.email,
    this.cep,
    this.telefone,
    this.dataNascimento,
    this.tipoUser,
    this.empresa,
    this.lat,
    this.lng,
    this.isOnline,
    {this.password}
  );

  UserProdDto toUserProdDto() {
    return UserProdDto(
      base: BaseDto(this.base.id),
      nome: this.nome,
      email: this.email,
      telefone: this.telefone,
      empresa: this.empresa,
      lat: this.lat,
      lng: this.lng,
      produtos: []
    );
  }
}
