import 'package:beach_service/app/app_widget.dart';
import 'package:beach_service/app/modules/pedido/pedido_controller.dart';
import 'package:beach_service/app/modules/user/dtos/user_prod_dto.dart';
import 'package:beach_service/app/shared/components/button/gradiente_button.dart';
import 'package:beach_service/app/shared/components/dialog/alert_dialog_widget.dart';
import 'package:beach_service/app/shared/components/icon_text_widget.dart';
import 'package:beach_service/app/shared/defaults/default_padding.dart';
import 'package:beach_service/app/shared/defaults/default_sized_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
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
    final TextTheme theme = Theme.of(context).textTheme;
    final IconThemeData iconTheme = Theme.of(context).iconTheme;

    Widget titleWidget(String title) => Text(title, style: theme.bodyText1);
    Widget descricaoWidget(String text) => Text(text, style: theme.bodyText2.copyWith(color: Colors.grey[700]));

    return Scaffold(
      appBar: AppBar(
        title: Text("Pedido"),
        iconTheme: iconTheme.copyWith(color: PaletaCores.light)
      ),
      body: Padding(
        padding: DefaultPadding.paddingList,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    //region Itens produtos
                    Row(
                      children: [
                        titleWidget("Itens"),
                        SizedBox(width: 16),
                        TextButton(
                          child: Text("Alterar", style: theme.bodyText1.copyWith(color: PaletaCores.primaryLight)),
                          onPressed: controller.toProdutoPage,
                        ),
                      ],
                    ),
                    Observer(
                      builder: (_) => ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: controller.pedidoStore?.itensPedido?.length ?? 0,
                        itemBuilder: (_, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                descricaoWidget(controller.pedidoStore.itensPedido[index].descricao),
                                Text(
                                  controller.pedidoStore.itensPedido[index].categoriaDto.descricao,
                                  style: theme.bodyText2.copyWith(color: Colors.grey),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    //endregion

                    DefaultSizedBox(),

                    //region Dados usuário
                    titleWidget("Vendedor"),
                    SizedBox(height: 10),
                    descricaoWidget("Nome: ${controller.pedidoStore.userVendedor.nome}"),
                    descricaoWidget("Empresa: ${controller.pedidoStore.userVendedor.empresa}"),
                    descricaoWidget("Email: ${controller.pedidoStore.userVendedor.email}"),
                    //endregion

                    DefaultSizedBox(),

                    //region distancia
                    titleWidget("Distância"),
                    SizedBox(height: 10),
                    descricaoWidget("500 metros"),
                    //endregion

                    DefaultSizedBox(),
                  ],
                ),
              ),
            ),
            GradienteButton(
              onPressed: () async {
                try {} catch (e) {
                  AlertDialogWidget.show(context, content: "$e");
                }
              },
              child: IconTextWidget(
                text: "Enviar Pedido",
                icon: Icons.send,
                color: Colors.white,
              ),
              colors: PaletaCores.gradiente,
            ),
          ],
        ),
      ),
    );
  }
}

// Enviar pedido
