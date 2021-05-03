import 'package:beach_service/app/modules/login/dtos/login_dto.dart';

abstract class IBaseRepository<T> {
  Future<List<T>> getAll();
  Future<T> getFirst();
  Future<T> getById(int id, {LoginDto loginDto});
  Future<T> save(T dto);
  Future<T> update(T dto);
  Future<bool> delete(int id);
}