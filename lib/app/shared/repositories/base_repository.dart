import 'package:beach_service/app/shared/repositories/base_repository_interface.dart';

abstract class BaseRepository<T> implements IBaseRepository<T> {
  @override
  Future<List<T>> getAll() {
    // TODO: implement getAll
    throw UnimplementedError();
  }

  @override
  Future<T> getById(int id) {
    // TODO: implement getById
    throw UnimplementedError();
  }

  @override
  Future<T> getFirst() {
    // TODO: implement getFirst
    throw UnimplementedError();
  }

  @override
  Future<T> save(T dto) {
    // TODO: implement save
    throw UnimplementedError();
  }

  @override
  Future<T> update(T dto) {
    // TODO: implement update
    throw UnimplementedError();
  }

  @override
  Future<bool> delete(int id) {
    // TODO: implement delete
    throw UnimplementedError();
  }
}