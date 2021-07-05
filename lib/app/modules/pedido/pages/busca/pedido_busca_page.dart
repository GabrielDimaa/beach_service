import 'package:beach_service/app/app_widget.dart';
import 'package:beach_service/app/modules/pedido/enums/enum_status_pedido.dart';
import 'package:beach_service/app/modules/pedido/pages/busca/pedido_busca_controller.dart';
import 'package:beach_service/app/shared/components/avatar/avatar_widget.dart';
import 'package:beach_service/app/shared/components/drawer/drawer_widget.dart';
import 'package:beach_service/app/shared/components/loading/loading.dart';
import 'package:beach_service/app/shared/defaults/default_padding.dart';
import 'package:beach_service/app/shared/routes/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';

class PedidoBuscaPage extends StatefulWidget {
  @override
  _PedidoBuscaPageState createState() => _PedidoBuscaPageState();
}

class _PedidoBuscaPageState extends ModularState<PedidoBuscaPage, PedidoBuscaController> {
  @override
  void initState() {
    super.initState();

    _init();
  }

  Future<void> _init() async => await controller.load();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text("Seus Pedidos"), iconTheme: theme.iconTheme.copyWith(color: PaletaCores.primaryLight)),
      drawer: DrawerWidget(),
      body: Padding(
        padding: DefaultPadding.paddingList,
        child: Observer(
          builder: (_) {
            if (controller.loading) return LoadingWidget(description: "Aguarde...\nBuscando seus pedidos.");
            if ((controller.pedidos?.length ?? 0) > 0)
              return ListView.separated(
                separatorBuilder: (_, __) => Container(height: 0.5, color: Colors.grey[300]),
                itemCount: controller.pedidos?.length ?? 0,
                itemBuilder: (_, index) {
                  String nome = "";
                  if (controller.pedidoController.appController.userStore.isVendedor)
                    nome = controller.pedidos[index].userConsumidor.nome;
                  else
                    nome = controller.pedidos[index].userVendedor.nome;
                  return Observer(
                    builder: (_) => ListTile(
                      leading: AvatarWidget(
                        backgroundColor: PaletaCores.primaryLight,
                        circleSize: 48,
                        iconSize: 30,
                        iconColor: Colors.white,
                      ),
                      title: Text(nome, style: theme.textTheme.bodyText1),
                      subtitle: Text(
                        EnumStatusPedidoHelper.description(controller.pedidos[index].statusPedido),
                        style: TextStyle(color: PaletaCores.primaryLight),
                      ),
                      trailing: Icon(Icons.keyboard_arrow_right),
                      onTap: () => Modular.to.pushNamed("/$PEDIDO_ROUTE/$PEDIDO_RESUMO_ROUTE", arguments: controller.pedidos[index]),
                    ),
                  );
                },
              );
            else
              return pedidosEmptyWidget(theme);
          },
        ),
      ),
    );
  }

  Widget pedidosEmptyWidget(ThemeData theme) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          'assets/images/empty.svg',
          height: 200,
          semanticsLabel: 'Acme Logo',
        ),
        Text(
          controller.message,
          style: theme.textTheme.bodyText1,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
