import 'package:beach_service/app/modules/pedido/pedido_controller.dart';
import 'package:beach_service/app/modules/pedido/repositories/pedido_repository.dart';
import 'package:beach_service/app/modules/pedido/repositories/pedido_repository_interface.dart';
import 'package:beach_service/app/modules/pedido/services/pedido_service.dart';
import 'package:beach_service/app/modules/pedido/services/pedido_service_interface.dart';
import 'package:beach_service/app/modules/produto/produto_controller.dart';
import 'package:beach_service/app/modules/produto/produto_page.dart';
import 'package:beach_service/app/modules/produto/repositories/produto_repository.dart';
import 'package:beach_service/app/modules/produto/repositories/produto_repository_interface.dart';
import 'package:beach_service/app/modules/produto/services/produto_service.dart';
import 'package:beach_service/app/modules/produto/services/produto_service_interface.dart';
import 'package:beach_service/app/modules/user/repositories/user_repository.dart';
import 'package:beach_service/app/modules/user/repositories/user_repository_interface.dart';
import 'package:beach_service/app/modules/user/services/user_service.dart';
import 'package:beach_service/app/modules/user/services/user_service_interface.dart';
import 'package:beach_service/app/modules/user/pages/cadastro/user_cadastro_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ProdutoModule extends Module {
  @override
  final List<Bind> binds = [
    //Repositories
    Bind((i) => ProdutoRepository()),
    Bind((i) => UserRepository()),
    Bind((i) => PedidoRepository()),

    //Services
    Bind((i) => ProdutoService(i.get<IProdutoRepository>())),
    Bind((i) => UserService(i.get<IUserRepository>())),
    Bind((i) => PedidoService(i.get<IPedidoRepository>())),

    //Controllers
    Bind((i) => UserCadastroController(i.get<IUserService>())),
    Bind((i) => PedidoController(i.get<IPedidoService>())),
    Bind((i) => ProdutoController(
          i.get<IProdutoService>(),
          i.get<IUserService>(),
          i.get<UserCadastroController>(),
          i.get<PedidoController>(),
        )),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => ProdutoPage()),
  ];
}
