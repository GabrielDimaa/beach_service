import 'package:beach_service/app/modules/login/dtos/login_dto.dart';
import 'package:beach_service/app/modules/login/repositories/login_repository_interface.dart';
import 'package:beach_service/app/shared/api/api.dart';
import 'package:beach_service/app/shared/dtos/base_dto.dart';
import 'package:beach_service/app/shared/preferences/auth_preferences.dart';
import 'package:beach_service/app/shared/repositories/base_repository.dart';
import 'package:beach_service/app/shared/extensions/string_extension.dart';
import 'package:beach_service/app/shared/extensions/email_extension.dart';
import 'package:dio/dio.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class LoginRepository extends BaseRepository<LoginDto> implements ILoginRepository {
  @override
  String getRoute() => "${BaseURL.baseURL}/users/auth";

  static Api api = Api();

  @override
  void validate(LoginDto dto) {
    if (dto.email.isNullOrEmpty() || !dto.email.isEmailValid()) throw Exception("Informe um email válido.");
    if (dto.password.isNullOrEmpty()) throw Exception("Informe uma senha.");
  }

  @override
  Map<String, dynamic> toMap(LoginDto dto) {
    return {
      'email': dto.email,
      'password': dto.password,
    };
  }

  @override
  LoginDto fromMap(Map<String, dynamic> e) {
    return LoginDto(
      base: BaseDto(JwtDecoder.decode(e['token'])['uid']),
      token: e['token'],
    );
  }

  @override
  Future<LoginDto> auth(LoginDto dto) async {
    validate(dto);

    try {
      var response = await api.post(getRoute(), data: toMap(dto));

      LoginDto dtoResponse = fromMap(response.data);

      if (dtoResponse?.base?.id == null && dtoResponse?.token == null)
        throw Exception("Ocorreu algum erro ao fazer Login!\nTente novamente.");

      dto.base = dtoResponse.base;
      dto.token = dtoResponse.token;

      await AuthPreferences().delete();
      await AuthPreferences().save(dto);

      return dto;
    } on DioError catch(e) {
      if (e.response != null) throw Exception(e.response.data[0]['message']);
      throw Exception(e);
    } catch(e) {
      throw Exception(e);
    }
  }
}