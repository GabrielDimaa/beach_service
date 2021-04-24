import 'package:beach_service/app/modules/login/login_controller.dart';
import 'package:beach_service/app/modules/login/login_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class LoginModule extends Module {
  @override
  final List<Bind> binds = [
    Bind((i) => LoginController()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => LoginPage()),
  ];
}