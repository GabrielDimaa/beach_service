import 'package:beach_service/app/modules/home/home_module.dart';
import 'package:beach_service/app/modules/login/login_controller.dart';
import 'package:beach_service/app/modules/login/login_module.dart';
import 'package:beach_service/app/modules/login/repositories/login_repository.dart';
import 'package:beach_service/app/modules/login/repositories/login_repository_interface.dart';
import 'package:beach_service/app/modules/login/services/login_service.dart';
import 'package:beach_service/app/modules/login/services/login_service_interface.dart';
import 'package:beach_service/app/modules/produto/produto_controller.dart';
import 'package:beach_service/app/modules/produto/produto_module.dart';
import 'package:beach_service/app/modules/produto/repositories/produto_repository.dart';
import 'package:beach_service/app/modules/produto/repositories/produto_repository_interface.dart';
import 'package:beach_service/app/modules/produto/services/produto_service.dart';
import 'package:beach_service/app/modules/produto/services/produto_service_interface.dart';
import 'package:beach_service/app/modules/user/repositories/user_repository.dart';
import 'package:beach_service/app/modules/user/repositories/user_repository_interface.dart';
import 'package:beach_service/app/modules/user/services/user_service.dart';
import 'package:beach_service/app/modules/user/services/user_service_interface.dart';
import 'package:beach_service/app/modules/user/user_controller.dart';
import 'package:beach_service/app/modules/user/user_module.dart';
import 'package:beach_service/app/shared/routes/routes.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    //Repositories
    Bind((i) => LoginRepository()),
    Bind((i) => UserRepository()),
    Bind((i) => ProdutoRepository()),

    //Services
    Bind((i) => LoginService(i.get<ILoginRepository>())),
    Bind((i) => UserService(i.get<IUserRepository>())),
    Bind((i) => ProdutoService(i.get<IProdutoRepository>())),

    //Controllers
    Bind((i) => LoginController(
          i.get<ILoginService>(),
          i.get<IUserService>(),
          i.get<UserController>(),
          i.get<ProdutoController>(),
        )),
    Bind((i) => UserController(i.get<IUserService>())),
    Bind((i) => ProdutoController(
          i.get<IProdutoService>(),
          i.get<IUserService>(),
          i.get<UserController>(),
        )),
  ];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute(Modular.initialRoute, module: LoginModule()),
    ModuleRoute("/$USER_ROUTE", module: UserModule()),
    ModuleRoute("/$PRODUTO_ROUTE", module: ProdutoModule()),
    ModuleRoute("/$HOME_ROUTE", module: HomeModule()),
  ];
}
