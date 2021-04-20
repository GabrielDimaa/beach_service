import 'package:beach_service/app/modules/user/user_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:beach_service/app/modules/user/user_page.dart';

class UserModule extends Module {
  @override
  final List<Bind> binds = [
    Bind((i) => UserController())
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => UserPage()),
  ];
}