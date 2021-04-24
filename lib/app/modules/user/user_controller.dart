import 'package:beach_service/app/modules/user/dtos/user_dto.dart';
import 'package:beach_service/app/modules/user/services/user_service_interface.dart';
import 'package:beach_service/app/modules/user/stores/user_store.dart';
import 'package:beach_service/app/shared/interfaces/form_controller_interface.dart';
import 'package:mobx/mobx.dart';

part 'user_controller.g.dart';

class UserController = _UserControllerBase with _$UserController;

abstract class _UserControllerBase with Store implements IFormController {
  final IUserService userService;

  _UserControllerBase(this.userService);

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
    loading = true;

    if (userStore != null) {
      UserDto userDto = userStore.toDto();
      UserDto dto = await userService.saveOrUpdate(userDto);
    }

    loading = false;
  }

  @action
  Future<void> delete() {}
}
