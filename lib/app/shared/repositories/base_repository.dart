import 'package:beach_service/app/shared/dtos/base_dto_interface.dart';
import 'package:beach_service/app/shared/repositories/base_repository_interface.dart';
import 'package:beach_service/app/shared/extensions/list_extension.dart';
import 'package:dio/dio.dart';

abstract class BaseRepository<T extends IBaseDto> implements IBaseRepository<T> {
  String getRoute();

  void validate(T dto);

  Map<String, dynamic> toMap(T dto);

  T fromMap(Map<String, dynamic> e);

  static Dio dio = Dio();

  @override
  Future<List<T>> getAll() async {
    Response response = await dio.get(getRoute());

    print("<<<< $response");
    print("ERROOOOOOOO");
    throw Exception("ERROOOOOOOO");
  }

  @override
  Future<T> getById(int id) async {
    if (id == null) throw Exception("Não encontrado!");

    Response response = await dio.get("${getRoute()}/$id");

    print("<<<< $response");
    print("ERROOOOOOOO");
    throw Exception("ERROOOOOOOO");
  }

  @override
  Future<T> getFirst() async {
    List<T> listT = await getAll();

    T t = listT.firstOrNull;

    print("<<<< $t");
    print("ERROOOOOOOO");
    throw Exception("ERROOOOOOOO");
  }

  @override
  Future<T> save(T dto) async {
    try {
      this.validate(dto);
      Map<String, dynamic> map = toMap(dto);

      Response response =  await dio.post(getRoute(), queryParameters: map);

      // ver retorno do response
      print("<<<< $response");
      print("ERROOOOOOOO");
      throw Exception("ERROOOOOOOO");
    } catch(e) {
      throw Exception(e);
    }
  }

  @override
  Future<T> update(T dto) async {
    if (dto == null || dto.base.id == null) throw Exception("Não foi possível editar!");

    this.validate(dto);
    Map<String, dynamic> map = toMap(dto);

    Response response =  await dio.put("${getRoute()}/${dto.base.id}", queryParameters: map);

    // ver retorno do response
    print("<<<< $response");
    print("ERROOOOOOOO");
    throw Exception("ERROOOOOOOO");
  }

  @override
  Future<bool> delete(int id) async {
    if (id == null) throw Exception("Não foi possível fazer a exclusão!");

    Response response =  await dio.delete("${getRoute()}/$id");

    // ver retorno do response
    print("<<<< $response");
    print("ERROOOOOOOO");
    throw Exception("ERROOOOOOOO");
  }
}