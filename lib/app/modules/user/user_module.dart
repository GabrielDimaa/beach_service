import 'package:beach_service/app/app_controller.dart';
import 'package:beach_service/app/modules/home/home_controller.dart';
import 'package:beach_service/app/modules/home/services/sincronizacao_service_interface.dart';
import 'package:beach_service/app/modules/produto/repositories/produto_repository.dart';
import 'package:beach_service/app/modules/produto/repositories/produto_repository_interface.dart';
import 'package:beach_service/app/modules/produto/services/produto_service.dart';
import 'package:beach_service/app/modules/produto/services/produto_service_interface.dart';
import 'package:beach_service/app/modules/user/pages/cadastro/tipo_user_page.dart';
import 'package:beach_service/app/modules/user/pages/cadastro/user_cadastro_controller.dart';
import 'package:beach_service/app/modules/user/pages/cadastro/user_cadastro_page.dart';
import 'package:beach_service/app/modules/user/pages/user_controller.dart';
import 'package:beach_service/app/modules/user/pages/user_page.dart';
import 'package:beach_service/app/modules/user/repositories/user_repository.dart';
import 'package:beach_service/app/modules/user/repositories/user_repository_interface.dart';
import 'package:beach_service/app/modules/user/services/user_service.dart';
import 'package:beach_service/app/modules/user/services/user_service_interface.dart';
import 'package:beach_service/app/shared/routes/routes.dart';
import 'package:flutter_modular/flutter_modular.dart';

class UserModule extends Module {
  @override
  final List<Bind> binds = [
    //Repositories
    Bind((i) => UserRepository()),
    Bind((i) => ProdutoRepository()),

    //Services
    Bind((i) => UserService(i.get<IUserRepository>())),
    Bind((i) => ProdutoService(i.get<IProdutoRepository>())),

    //Controllers
    Bind((i) => AppController()),
    Bind((i) => UserController(i.get<IUserService>(), i.get<IProdutoService>(), i.get<AppController>())),
    Bind((i) => UserCadastroController(i.get<IUserService>(), i.get<AppController>())),
    Bind((i) => HomeController(
          i.get<IUserService>(),
          i.get<ISincronizacaoService>(),
          i.get<AppController>(),
        )),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => UserPage(userProdDto: args.data)),
    ChildRoute("/$USER_CADASTRO_ROUTE", child: (_, args) => UserCadastroPage(userStore: args.data,)),
    ChildRoute("/$TIPO_USER_ROUTE", child: (_, args) => TipoUserPage()),
  ];
}
