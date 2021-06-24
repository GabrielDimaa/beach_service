import 'package:beach_service/app/modules/user/dtos/user_prod_dto.dart';
import 'package:beach_service/app/modules/user/dtos/user_dto.dart';
import 'package:beach_service/app/shared/repositories/base_repository_interface.dart';

abstract class IUserRepository implements IBaseRepository<UserDto> {
  Future<List<UserProdDto>> getAllUserProd(UserDto userDto);
  UserProdDto fromMapUserProd(Map<String, dynamic> e);
  Map<String, dynamic> toMapUserProd(UserProdDto userDto);
}