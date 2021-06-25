import 'package:beach_service/app/modules/pedido/pages/busca/pedido_busca_controller.dart';
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
    // Theme para Button da AppBar
    final themeAppBar = theme.appBarTheme.textTheme.headline6.copyWith(fontSize: 18, fontWeight: FontWeight.bold);
    final style = themeAppBar.copyWith(color: Colors.grey);
    return Observer(
      builder: (_) => Scaffold(
        body: Container(),
      ),
    );
  }
}
