import 'package:beach_service/app/modules/produto/dtos/produto_dto.dart';
import 'package:beach_service/app/modules/produto/repositories/produto_repository.dart';
import 'package:beach_service/app/modules/user/dtos/user_dto.dart';
import 'package:beach_service/app/modules/user/dtos/user_prod_dto.dart';
import 'package:beach_service/app/modules/user/enums/enum_tipo_user.dart';
import 'package:beach_service/app/modules/user/repositories/user_repository_interface.dart';
import 'package:beach_service/app/shared/api/api.dart';
import 'package:beach_service/app/shared/dtos/base_dto.dart';
import 'package:beach_service/app/shared/repositories/base_repository.dart';
import 'package:beach_service/app/shared/extensions/string_extension.dart';
import 'package:beach_service/app/shared/extensions/email_extension.dart';
import 'package:beach_service/app/shared/extensions/date_extension.dart';
import 'package:dio/dio.dart';

class UserRepository extends BaseRepository<UserDto> implements IUserRepository {
  @override
  String getRoute() => "${BaseURL.baseURL}/users";

  static Api api = Api();

  @override
  void validate(UserDto dto) {
    if (dto.nome.isNullOrEmpty()) throw Exception("Informe o seu nome.");
    if (dto.email.isNullOrEmpty() || !dto.email.isEmailValid()) throw Exception("Informe um email válido.");
    if (dto.password.isNullOrEmpty() || dto.password.length <= 8) throw Exception("Informe uma senha válida.");
    if (dto.cep.isNullOrEmpty() || dto.cep.extrairNum().length != 8) throw Exception("Informe um CEP válido.");
    if (dto.telefone.isNullOrEmpty() || dto.telefone.extrairNum().length < 10) throw Exception("Informe um telefone válido.");
    if (dto.dataNascimento == null) throw Exception("Informe uma data de nascimento válida.");
    if (dto.tipoUser == null) throw Exception("Informe se você é Consumidor ou Vendedor.");
    if (dto.tipoUser == EnumTipoUser.Vendedor && dto.empresa.isNullOrEmpty()) throw Exception("Informe o nome da empresa.");
  }

  @override
  Map<String, dynamic> toMap(UserDto dto) {
    return {
      'id': dto.base?.id,
      'nome': dto.nome,
      'email': dto.email,
      'password': dto.password,
      'cep': dto.cep,
      'telefone': dto.telefone,
      'data_nascimento': dto.dataNascimento?.formatedSql,
      'tipo_user': EnumTipoUserHelper.getValue(dto.tipoUser),
      'empresa': dto.empresa,
      'lat': dto.lat,
      'lng': dto.lng,
      'online': dto.isOnline ?? false,
    };
  }

  @override
  Map<String, dynamic> toMapUserProd(UserProdDto dto) {
    List<Map<String, dynamic>> produtos = [];
    dto.produtos.forEach((e) => produtos.add({'id': dto.base.id}));

    return {
      'id': dto.base?.id,
      'nome': dto.nome,
      'email': dto.email,
      'telefone': dto.telefone,
      'empresa': dto.empresa,
      'lat': dto.lat,
      'lng': dto.lng,
      'produto': produtos,
    };
  }

  @override
  UserDto fromMap(Map<String, dynamic> e) {
    return UserDto(
      BaseDto(e['id']),
      e['nome'],
      e['email'],
      e['cep'],
      e['telefone'],
      (e['data_nascimento']).toString().parseToDateTime(),
      EnumTipoUserHelper.get(e['tipo_user']),
      e['empresa'],
      e['lat'],
      e['lng'],
      e['online'] == 0
          ? false
          : e['online'] == 1
              ? true
              : null,
      password: e['password'],
    );
  }

  @override
  UserProdDto fromMapUserProd(Map<String, dynamic> e) {
    List<dynamic> produtosMap = e['produtos'];
    List<ProdutoDto> produtos = [];

    if (produtosMap != null && produtosMap.isNotEmpty) produtosMap.forEach((element) => produtos.add(ProdutoRepository().fromMap(element)));

    return UserProdDto(
      base: BaseDto(e['id']),
      nome: e['nome'],
      email: e['email'],
      telefone: e['telefone'],
      empresa: e['empresa'],
      lat: e['lat'],
      lng: e['lng'],
      distance: double.parse(e['distance'].toString()),
      produtos: produtos,
    );
  }

  @override
  Future<UserDto> save(UserDto dto) async {
    UserDto userDto = await super.save(dto);

    if (userDto.base.id == null) throw Exception("Erro ao identificar usuário!");

    return userDto;
  }

  @override
  Future<List<UserProdDto>> getAllUserProd(UserDto userDto) async {
    try {
      if (userDto.lat == null || userDto.lng == null) throw Exception("Houve algum problema em buscar sua localização.");

      List<UserProdDto> listUsers = [];

      Response response = await
      api.get(
        getRoute(),
        queryParameters: {
          'tipo_user': EnumTipoUserHelper.getValue(userDto.tipoUser),
          'lat': userDto.lat,
          'lng': userDto.lng,
        },
      );

      if (response?.data == null) throw Exception("Houve um problema ao sincronizar com o mapa!");

      (response.data as List).forEach((element) {
        listUsers.add(fromMapUserProd(element));
      });

      return listUsers;
    } on DioError catch (e) {
      if (e.response != null) throw Exception(e.response.data[0]['message']);
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }
}
