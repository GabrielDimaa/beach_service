import 'package:beach_service/app/app_widget.dart';
import 'package:beach_service/app/modules/pedido/pages/busca/pedido_busca_controller.dart';
import 'package:beach_service/app/shared/components/avatar/avatar_widget.dart';
import 'package:beach_service/app/shared/components/drawer/drawer_widget.dart';
import 'package:beach_service/app/shared/defaults/default_padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

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
      appBar: AppBar(title: Text("Seus Pedidos"), iconTheme: theme.iconTheme.copyWith(color: PaletaCores.light)),
      drawer: DrawerWidget(),
      body: Padding(
        padding: DefaultPadding.paddingList,
        child: ListView.separated(
          separatorBuilder: (_, __) => Container(height: 0.5, color: Colors.grey[300]),
          itemCount: 15,
          itemBuilder: (_, index) {
            return ListTile(
              leading: AvatarWidget(
                backgroundColor: PaletaCores.primaryLight,
                circleSize: 48,
                iconSize: 30,
                iconColor: Colors.white,
              ),
              title: Text("Gabriel de Matos", style: theme.textTheme.bodyText1),
              subtitle: Text("16/12/2020 13:50"),
              trailing: IconButton(icon: Icon(Icons.keyboard_arrow_right)),
              onTap: () {},
            );
          },
        ),
      ),
    );
  }
}
