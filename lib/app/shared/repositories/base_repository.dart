import 'package:beach_service/app/modules/login/dtos/login_dto.dart';
import 'package:beach_service/app/shared/api/api.dart';
import 'package:beach_service/app/shared/dtos/base_dto_interface.dart';
import 'package:beach_service/app/shared/repositories/base_repository_interface.dart';
import 'package:beach_service/app/shared/extensions/list_extension.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class BaseRepository<T extends IBaseDto> implements IBaseRepository<T> {
  String getRoute();

  void validate(T dto);

  Map<String, dynamic> toMap(T dto);

  T fromMap(Map<String, dynamic> e);

  static Api api = Api();

  @override
  Future<List<T>> getAll() async {
    List response = (await api.get(getRoute())).data;
    List<T> list = [];

    if (response.isNotEmpty) {
      response.forEach((e) {
        list.add(fromMap(e));
      });
    }

    return list;
  }

  @override
  Future<T> getById(int id, {LoginDto loginDto}) async {
    if (id == null) throw Exception("Não encontrado!");

    dynamic response = (await api.get("${getRoute()}/$id")).data;

    if (response != null) {
      return fromMap(response);
    }

    return null;
  }

  @override
  Future<T> getFirst() async {
    List<T> listT = await getAll();

    T t = listT.firstOrNull;

    print("<<<< $t");
    print("FALTA IMPLEMENTAR, APENAS QUANDO PRECISAR");
    throw Exception("FALTA IMPLEMENTAR, APENAS QUANDO PRECISAR");
  }

  @override
  Future<T> save(T dto) async {
    try {
      this.validate(dto);

      Map<String, dynamic> data = toMap(dto);

      dynamic response = (await api.post(getRoute(), data: data)).data;

      if (response != null)
        return fromMap(response);

      return null;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<T> update(T dto) async {
    if (dto == null || dto.base.id == null) throw Exception("Não foi possível editar!");

    this.validate(dto);
    Map<String, dynamic> map = toMap(dto);

    Response response = await api.put("${getRoute()}/${dto.base.id}", queryParameters: map);

    // ver retorno do response
    print("<<<< $response");
    print("FALTA IMPLEMENTAR, APENAS QUANDO PRECISAR");
    throw Exception("FALTA IMPLEMENTAR, APENAS QUANDO PRECISAR");
  }

  @override
  Future<bool> delete(int id) async {
    if (id == null) throw Exception("Não foi possível fazer a exclusão!");

    Response response = await api.delete("${getRoute()}/$id");

    // ver retorno do response
    print("<<<< $response");
    print("FALTA IMPLEMENTAR, APENAS QUANDO PRECISAR");
    throw Exception("FALTA IMPLEMENTAR, APENAS QUANDO PRECISAR");
  }
}
