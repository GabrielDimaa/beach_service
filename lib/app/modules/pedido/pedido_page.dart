import 'package:beach_service/app/modules/pedido/pedido_controller.dart';
import 'package:beach_service/app/modules/user/dtos/user_prod_dto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class PedidoPage extends StatefulWidget {
  final UserProdDto userVendedor;

  const PedidoPage({Key key, this.userVendedor}) : super(key: key);

  @override
  PedidoPageState createState() => PedidoPageState();
}

class PedidoPageState extends ModularState<PedidoPage, PedidoController> {
  @override
  void initState() {
    super.initState();

    controller.pedidoStore.setUserVendedor(widget.userVendedor);

    _init();
  }

  Future<void> _init() async {
    await controller.load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Resumo do pedido"),
      ),
      body: Column(
        children: [],
      ),
    );
  }
}

// Enviar pedido

