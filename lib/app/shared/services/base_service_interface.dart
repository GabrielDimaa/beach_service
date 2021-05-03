import 'package:beach_service/app/modules/login/dtos/login_dto.dart';

abstract class IBaseService<T> {
  Future<List<T>> getAll();
  Future<T> getFirst();
  Future<T> getById(int id, {LoginDto loginDto});
  Future<T> saveOrUpdate(T dto);
  Future<void> delete(int id);
}