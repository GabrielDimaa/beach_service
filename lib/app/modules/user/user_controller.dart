import 'package:beach_service/app/modules/user/stores/user_store.dart';
import 'package:mobx/mobx.dart';

part 'user_controller.g.dart';

class UserController = UserControllerBase with _$UserController;

abstract class UserControllerBase with Store {
  @observable
  UserStore userStore = UserStore();

  @observable
  Function updateTextControllers;

  @observable
  bool loading = false;

  @action
  void setUpdateTextControllers(Function function) => updateTextControllers = function;

  @action
  void setLoading(bool value) => loading = value;

  @action
  void load() {
    try {
      loading = true;
    } finally {
      loading = false;
      updateTextControllers?.call();
    }
  }
}