import 'package:beach_service/app/app_controller.dart';
import 'package:beach_service/app/modules/home/home_controller.dart';
import 'package:beach_service/app/modules/home/services/sincronizacao_service_interface.dart';
import 'package:beach_service/app/modules/splach/splach_controller.dart';
import 'package:beach_service/app/modules/splach/splach_page.dart';
import 'package:beach_service/app/modules/user/repositories/user_repository.dart';
import 'package:beach_service/app/modules/user/repositories/user_repository_interface.dart';
import 'package:beach_service/app/modules/user/services/user_service.dart';
import 'package:beach_service/app/modules/user/services/user_service_interface.dart';
import 'package:beach_service/app/modules/user/pages/cadastro/user_cadastro_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SplachModule extends Module {
  @override
  final List<Bind> binds = [
    //Repositories
    Bind((i) => UserRepository()),

    //Services
    Bind((i) => UserService(i.get<IUserRepository>())),

    //Controllers
    Bind((i) => AppController()),
    Bind((i) => SplachController(i.get<AppController>())),
    Bind((i) => UserCadastroController(i.get<IUserService>(), i.get<AppController>())),
    Bind((i) => HomeController(i.get<IUserService>(), i.get<ISincronizacaoService>(), i.get<AppController>())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => SplachPage()),
  ];
}