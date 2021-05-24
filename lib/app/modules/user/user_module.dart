import 'package:beach_service/app/modules/user/pages/cadastro/tipo_user_page.dart';
import 'package:beach_service/app/modules/user/pages/user_controller.dart';
import 'package:beach_service/app/modules/user/pages/user_page.dart';
import 'package:beach_service/app/modules/user/repositories/user_repository.dart';
import 'package:beach_service/app/modules/user/repositories/user_repository_interface.dart';
import 'package:beach_service/app/modules/user/services/user_service.dart';
import 'package:beach_service/app/modules/user/services/user_service_interface.dart';
import 'package:beach_service/app/modules/user/pages/cadastro/user_cadastro_controller.dart';
import 'package:beach_service/app/shared/routes/routes.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:beach_service/app/modules/user/pages/cadastro/user_cadastro_page.dart';

class UserModule extends Module {
  @override
  final List<Bind> binds = [
    Bind((i) => UserRepository()),
    Bind((i) => UserService(i.get<IUserRepository>())),
    Bind((i) => UserController()),
    Bind((i) => UserCadastroController(i.get<IUserService>())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => UserPage()),
    ChildRoute("/$USER_CADASTRO_ROUTE", child: (_, args) => UserCadastroPage()),
    ChildRoute("/$TIPO_USER_ROUTE", child: (_, args) => TipoUserPage()),
  ];
}
