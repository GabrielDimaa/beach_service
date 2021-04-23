abstract class IFormController {
  bool loading;

  Future<void> load();
  Future<void> save();
  Future<void> delete();
}