import 'package:beach_service/app/app_controller.dart';
import 'package:beach_service/app/modules/home/services/sincronizacao_service_interface.dart';
import 'package:beach_service/app/modules/pedido/pages/busca/pedido_busca_controller.dart';
import 'package:beach_service/app/modules/pedido/pages/busca/pedido_busca_page.dart';
import 'package:beach_service/app/modules/pedido/pages/pedido_controller.dart';
import 'package:beach_service/app/modules/pedido/pages/pedido_page.dart';
import 'package:beach_service/app/modules/pedido/repositories/pedido_repository.dart';
import 'package:beach_service/app/modules/pedido/repositories/pedido_repository_interface.dart';
import 'package:beach_service/app/modules/pedido/services/pedido_service.dart';
import 'package:beach_service/app/modules/pedido/services/pedido_service_interface.dart';
import 'package:beach_service/app/shared/routes/routes.dart';
import 'package:flutter_modular/flutter_modular.dart';

class PedidoModule extends Module {
  @override
  final List<Bind> binds = [
    Bind((i) => PedidoRepository()),
    Bind((i) => PedidoService(i.get<IPedidoRepository>())),
    Bind((i) => PedidoController(
          i.get<IPedidoService>(),
          i.get<AppController>(),
          i.get<ISincronizacaoService>(),
        )),
    Bind((i) => PedidoBuscaController(
          i.get<IPedidoService>(),
          i.get<PedidoController>(),
        )),
    Bind((i) => AppController()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => PedidoPage(userVendedor: args.data)),
    ChildRoute("/$PEDIDO_RESUMO_ROUTE", child: (_, args) => PedidoPage(pedidoStore: args.data)),
    ChildRoute("/$PEDIDO_BUSCA_ROUTE", child: (_, args) => PedidoBuscaPage()),
  ];
}
