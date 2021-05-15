import 'package:beach_service/app/modules/user/dtos/user_dto.dart';
import 'package:beach_service/app/modules/user/enums/enum_tipo_user.dart';
import 'package:beach_service/app/modules/user/repositories/user_repository_interface.dart';
import 'package:beach_service/app/modules/user/services/user_service_interface.dart';
import 'package:beach_service/app/shared/dtos/base_dto.dart';
import 'package:beach_service/app/shared/services/base_service.dart';

class UserService extends BaseService<UserDto, IUserRepository> implements IUserService {
  UserService(IUserRepository baseRepository) : super(baseRepository);

  @override
  Future<List<UserDto>> getAll({dynamic params}) async {
    List<UserDto> list = List.generate(
        8,
        (i) => UserDto(
              BaseDto(i + 1),
              "Teste Testando ${i + 1}",
              "teste@gmail.com",
              "95560-000",
              "(51) 99674-0385",
              DateTime(1999, 07, 02),
              EnumTipoUser.Vendedor,
              "Nestlé",
              -29.338450,
              -(49.721886 + 0.000200 * (i + 1)),
            ));
    return list;
  }
}
