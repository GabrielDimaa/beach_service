import 'package:beach_service/app/app_controller.dart';
import 'package:beach_service/app/modules/login/login_controller.dart';
import 'package:beach_service/app/modules/login/login_page.dart';
import 'package:beach_service/app/modules/login/repositories/login_repository.dart';
import 'package:beach_service/app/modules/login/repositories/login_repository_interface.dart';
import 'package:beach_service/app/modules/login/services/login_service.dart';
import 'package:beach_service/app/modules/login/services/login_service_interface.dart';
import 'package:flutter_modular/flutter_modular.dart';

class LoginModule extends Module {
  @override
  final List<Bind> binds = [
    //Repositories
    Bind((i) => LoginRepository()),

    //Services
    Bind((i) => LoginService(i.get<ILoginRepository>())),

    //Controllers
    Bind((i) => AppController()),
    Bind((i) => LoginController(i.get<ILoginService>(), i.get<AppController>())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => LoginPage()),
  ];
}
