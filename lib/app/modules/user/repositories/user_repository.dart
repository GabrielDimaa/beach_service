import 'package:beach_service/app/modules/user/dtos/user_dto.dart';
import 'package:beach_service/app/modules/user/enums/enum_tipo_user.dart';
import 'package:beach_service/app/modules/user/repositories/user_repository_interface.dart';
import 'package:beach_service/app/shared/api/api.dart';
import 'package:beach_service/app/shared/dtos/base_dto.dart';
import 'package:beach_service/app/shared/repositories/base_repository.dart';
import 'package:beach_service/app/shared/extensions/string_extension.dart';
import 'package:beach_service/app/shared/extensions/email_extension.dart';
import 'package:beach_service/app/shared/extensions/date_extension.dart';

class UserRepository extends BaseRepository<UserDto> implements IUserRepository {
  @override
  String getRoute() => "${BaseURL.baseURL}/users";

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
      'nome': dto.nome,
      'email': dto.email,
      'password': dto.password,
      'cep': dto.cep,
      'telefone': dto.telefone,
      'data_nascimento': dto.dataNascimento.formatedSql,
      'tipo_user': EnumTipoUserHelper.getValue(dto.tipoUser),
      'empresa': dto.empresa,
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
      password: e['password'],
    );
  }

  @override
  Future<UserDto> save(UserDto dto) async {
    UserDto userDto = await super.save(dto);

    if (userDto.base.id == null) throw Exception("Erro ao identificar usuário!");

    return userDto;
  }

  @override
  Future<List<UserDto>> getAll({dynamic params}) {
    return super.getAll(params: {'tipo_user': params});
  }
}