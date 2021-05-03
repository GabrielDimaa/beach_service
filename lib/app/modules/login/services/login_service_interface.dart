import 'package:beach_service/app/modules/login/dtos/login_dto.dart';
import 'package:beach_service/app/shared/services/base_service_interface.dart';

abstract class ILoginService implements IBaseService<LoginDto> {
  Future<LoginDto> auth(LoginDto dto);
}