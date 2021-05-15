abstract class IBaseService<T> {
  Future<List<T>> getAll({dynamic params});
  Future<T> getFirst();
  Future<T> getById(int id);
  Future<T> saveOrUpdate(T dto);
  Future<void> delete(int id);
}