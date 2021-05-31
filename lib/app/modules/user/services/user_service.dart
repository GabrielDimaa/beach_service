import 'package:beach_service/app/modules/user/dtos/user_dto.dart';
import 'package:beach_service/app/modules/user/dtos/user_prod_dto.dart';
import 'package:beach_service/app/modules/user/repositories/user_repository_interface.dart';
import 'package:beach_service/app/modules/user/services/user_service_interface.dart';
import 'package:beach_service/app/shared/services/base_service.dart';

class UserService extends BaseService<UserDto, IUserRepository> implements IUserService {
  UserService(IUserRepository baseRepository) : super(baseRepository);

  @override
  Future<List<UserProdDto>> getAllUserProd(UserDto userDto) async => await baseRepository.getAllUserProd(userDto);
  //   List<ProdutoDto> produtos1 =
  //   List.generate(10, (index) => ProdutoDto(BaseDto(index), "Comida ${index + 1}", CategoriaDto(BaseDto(1), "Comida")));
  //   List<ProdutoDto> produtos2 =
  //   List.generate(10, (index) => ProdutoDto(BaseDto(index + 10), "Bazar ${index}", CategoriaDto(BaseDto(2), "Bazar")));
  //   List<ProdutoDto> produtos3 =
  //   List.generate(10, (index) => ProdutoDto(BaseDto(index + 20), "Bebidas ${index}", CategoriaDto(BaseDto(3), "Bebidas")));
  //
  //   List<ProdutoDto> lista = [];
  //   lista.addAll(produtos1);
  //   lista.addAll(produtos2);
  //   lista.addAll(produtos3);
  //
  //   List<UserProdDto> list = List.generate(
  //       8,
  //           (i) =>
  //           UserProdDto(
  //               base: BaseDto(i + 1),
  //               nome: "Teste Testando ${i + 1}",
  //               email: "teste@gmail.com",
  //               telefone: "(51) 99674-0385",
  //               empresa: "Nestlé",
  //               lat: -29.338450,
  //               lng: -(49.721886 + 0.000200 * (i + 1)),
  //               produtos: lista
  //           ));
  //   return list;
  // }
}
