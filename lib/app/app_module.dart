import 'package:beach_service/app/modules/login/login_module.dart';
import 'package:beach_service/app/modules/produto/produto_module.dart';
import 'package:beach_service/app/modules/user/user_module.dart';
import 'package:beach_service/app/shared/routes/routes.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute(Modular.initialRoute, module: ProdutoModule()),
    ModuleRoute("/$USER_ROUTE", module: UserModule()),
    ModuleRoute("/$PRODUTO_ROUTE", module: ProdutoModule())
  ];
}