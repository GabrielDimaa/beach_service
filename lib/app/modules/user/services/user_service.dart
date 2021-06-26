import 'package:beach_service/app/modules/user/dtos/user_dto.dart';
import 'package:beach_service/app/modules/user/dtos/user_prod_dto.dart';
import 'package:beach_service/app/modules/user/repositories/user_repository_interface.dart';
import 'package:beach_service/app/modules/user/services/user_service_interface.dart';
import 'package:beach_service/app/shared/services/base_service.dart';

class UserService extends BaseService<UserDto, IUserRepository> implements IUserService {
  UserService(IUserRepository baseRepository) : super(baseRepository);

  @override
  Future<List<UserProdDto>> getAllUserProd(UserDto userDto) async => await baseRepository.getAllUserProd(userDto);
}
