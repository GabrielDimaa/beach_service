import 'package:beach_service/app/modules/home/home_controller.dart';
import 'package:beach_service/app/modules/user/repositories/user_repository.dart';
import 'package:beach_service/app/modules/user/repositories/user_repository_interface.dart';
import 'package:beach_service/app/modules/user/services/user_service.dart';
import 'package:beach_service/app/modules/user/services/user_service_interface.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'home_page.dart';

class HomeModule extends Module {
  @override
  final List<Bind> binds = [
    Bind((i) => UserRepository()),
    Bind((i) => UserService(i.get<IUserRepository>())),
    Bind((i) => HomeController(i.get<IUserService>())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => HomePage(dto: args.data)),
  ];
}
