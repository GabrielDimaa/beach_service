import 'package:beach_service/app/app_controller.dart';
import 'package:beach_service/app/modules/pedido/pedido_controller.dart';
import 'package:beach_service/app/modules/pedido/pedido_page.dart';
import 'package:beach_service/app/modules/pedido/repositories/pedido_repository.dart';
import 'package:beach_service/app/modules/pedido/repositories/pedido_repository_interface.dart';
import 'package:beach_service/app/modules/pedido/services/pedido_service.dart';
import 'package:beach_service/app/modules/pedido/services/pedido_service_interface.dart';
import 'package:flutter_modular/flutter_modular.dart';

class PedidoModule extends Module {
  @override
  final List<Bind> binds = [
    Bind((i) => PedidoRepository()),
    Bind((i) => PedidoService(i.get<IPedidoRepository>())),
    Bind((i) => PedidoController(i.get<IPedidoService>(), i.get<AppController>())),
    Bind((i) => AppController()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => PedidoPage(userVendedor: args.data,)),
  ];

}