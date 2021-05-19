import 'package:beach_service/app/modules/user/dtos/user_dto.dart';
import 'package:beach_service/app/modules/user/dtos/user_prod_dto.dart';
import 'package:beach_service/app/shared/services/base_service_interface.dart';

abstract class IUserService implements IBaseService<UserDto> {
  Future<List<UserProdDto>> getAllUserProd(UserDto userDto);
}