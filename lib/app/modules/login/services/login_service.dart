import 'package:beach_service/app/modules/login/dtos/login_dto.dart';
import 'package:beach_service/app/modules/login/repositories/login_repository_interface.dart';
import 'package:beach_service/app/modules/login/services/login_service_interface.dart';
import 'package:beach_service/app/shared/services/base_service.dart';

class LoginService extends BaseService<LoginDto, ILoginRepository> implements ILoginService{
  LoginService(ILoginRepository baseRepository) : super(baseRepository);

  @override
  Future<LoginDto> auth(LoginDto dto) async => await baseRepository.auth(dto);
}