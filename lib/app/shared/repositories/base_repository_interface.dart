abstract class IBaseRepository<T> {
  Future<List<T>> getAll({dynamic params});
  Future<T> getFirst();
  Future<T> getById(int id);
  Future<T> save(T dto);
  Future<T> update(T dto);
  Future<bool> delete(int id);
}