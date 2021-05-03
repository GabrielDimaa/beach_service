import 'package:beach_service/app/modules/login/dtos/login_dto.dart';
import 'package:beach_service/app/modules/login/repositories/login_repository_interface.dart';
import 'package:beach_service/app/shared/api/api.dart';
import 'package:beach_service/app/shared/dtos/base_dto.dart';
import 'package:beach_service/app/shared/repositories/base_repository.dart';
import 'package:beach_service/app/shared/sqflite/sqflite_helper.dart';
import 'package:beach_service/app/shared/extensions/string_extension.dart';
import 'package:beach_service/app/shared/extensions/email_extension.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:sqflite_common/sqlite_api.dart';

class LoginRepository extends BaseRepository<LoginDto> implements ILoginRepository {
  @override
  String getRoute() => "${BaseURL.baseURL}/users/auth";

  @override
  String tableName() => "auth";

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

  Map<String, dynamic> toMapDb(LoginDto dto) {
    return {
      'id': dto.base.id,
      'email': dto.email,
      'token': dto.token
    };
  }

  @override
  LoginDto fromMap(Map<String, dynamic> e) {
    return LoginDto(
      base: BaseDto(JwtDecoder.decode(e['token'])['uid']),
      token: e['token'],
    );
  }

  LoginDto fromMapDb(Map<String, dynamic> e) {
    return LoginDto(
      base: BaseDto(e['id']),
      email: e['email'],
      token: e['token'],
    );
  }

  @override
  Future<LoginDto> auth(LoginDto dto) async {
    validate(dto);

    Map<String, dynamic> response = (await api.post("http://127.0.0.1:3333/users/auth", data: toMap(dto))).data;

    LoginDto dtoDb = fromMap(response);
    dtoDb.email = dto.email;

    //await save(dtoDb);

    return dtoDb;
  }

  @override
  Future<LoginDto> save(LoginDto dto) async {
    var db = await SQFLiteHelper().getDb();
    await db.insert(tableName(), toMapDb(dto));

    return dto;
  }

  @override
  Future<void> create(Batch batch) async {
    batch.execute('''
      CREATE TABLE ${tableName()} (
        id INTEGER PRIMARY KEY,
        email TEXT,
        token TEXT
      );
    ''');
  }
}