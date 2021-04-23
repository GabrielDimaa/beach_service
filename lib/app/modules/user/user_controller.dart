import 'package:beach_service/app/modules/user/dtos/user_dto.dart';
import 'package:beach_service/app/modules/user/stores/user_store.dart';
import 'package:beach_service/app/shared/interfaces/form_controller_interface.dart';
import 'package:mobx/mobx.dart';

part 'user_controller.g.dart';

class UserController = UserControllerBase with _$UserController;

abstract class UserControllerBase with Store implements IFormController {
  @observable
  UserStore userStore = UserStore();

  @observable
  bool loading = false;

  @action
  void setLoading(bool value) => loading = value;

  @action
  Future<void> load() {}

  @action
  Future<void> save() async {
    UserDto userDto = userStore.toDto();

    print(userDto);
  }

  @action
  Future<void> delete() {}
}
