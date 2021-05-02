import 'package:beach_service/app/shared/dtos/base_dto.dart';
import 'package:beach_service/app/shared/dtos/base_dto_interface.dart';

class LoginDto implements IBaseDto {
  @override
  BaseDto base;

  String email;
  String password;
  String token;

  LoginDto({this.base, this.email, this.password, this.token});
}