import 'package:beach_service/app/app_widget.dart';
import 'package:beach_service/app/modules/pedido/dtos/pedido_dto.dart';
import 'package:beach_service/app/modules/pedido/enums/enum_status_pedido.dart';
import 'package:beach_service/app/modules/pedido/pages/pedido_controller.dart';
import 'package:beach_service/app/modules/pedido/stores/pedido_store.dart';
import 'package:beach_service/app/modules/user/dtos/user_prod_dto.dart';
import 'package:beach_service/app/shared/components/button/gradiente_button.dart';
import 'package:beach_service/app/shared/components/dialog/alert_dialog_widget.dart';
import 'package:beach_service/app/shared/components/icon_text_widget.dart';
import 'package:beach_service/app/shared/defaults/default_padding.dart';
import 'package:beach_service/app/shared/defaults/default_sized_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:beach_service/app/shared/extensions/date_extension.dart';

class PedidoPage extends StatefulWidget {
  final UserProdDto userVendedor;
  final PedidoStore pedidoStore;

  const PedidoPage({Key key, this.userVendedor, this.pedidoStore}) : super(key: key);

  @override
  PedidoPageState createState() => PedidoPageState();
}

class PedidoPageState extends ModularState<PedidoPage, PedidoController> {
  @override
  void initState() {
    super.initState();

    if (widget.pedidoStore != null) {
      controller.pedidoStore = widget.pedidoStore;
    } else {
      controller.pedidoStore.setUserVendedor(widget.userVendedor);
    }

    _init().then((value) => null);
  }

  Future<void> _init() async {
    controller.setContext(context);
    await controller.load();
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme theme = Theme.of(context).textTheme;
    final IconThemeData iconTheme = Theme.of(context).iconTheme;

    Widget titleWidget(String title) => Text(title, style: theme.bodyText1);
    Widget descricaoWidget(String text) => Text(text, style: theme.bodyText2.copyWith(color: Colors.grey[700]));
    return Scaffold(
      appBar: AppBar(title: Text("Pedido"), iconTheme: iconTheme.copyWith(color: PaletaCores.primaryLight)),
      body: Padding(
        padding: DefaultPadding.paddingList,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Observer(
                  builder: (_) => Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      //region Status pedido
                      Visibility(
                        visible: controller.pedidoRealizado,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                titleWidget("Data e Hora"),
                                SizedBox(height: 10),
                                Observer(
                                  builder: (_) => descricaoWidget("Criado em: ${controller.pedidoStore?.dataHoraCriado?.formatedWithHour ?? ""}"),
                                ),
                                Observer(
                                  builder: (_) => Visibility(
                                    visible: controller.pedidoStore?.dataHoraFinalizado != null,
                                    child: descricaoWidget("Finalizado em: ${controller.pedidoStore?.dataHoraFinalizado?.formatedWithHour ?? ""}"),
                                  ),
                                ),
                              ],
                            ),
                            Observer(
                              builder: (_) {
                                if (controller.pedidoStore?.statusPedido != null) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: PaletaCores.primaryLight, width: 1),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 6.0),
                                      child: Text(
                                        EnumStatusPedidoHelper.description(controller.pedidoStore?.statusPedido ?? 1),
                                        style: theme.bodyText2.copyWith(color: PaletaCores.primaryLight),
                                      ),
                                    ),
                                  );
                                } else {
                                  return Container();
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                      //endregion

                      DefaultSizedBox(),

                      //region Itens produtos
                      Row(
                        children: [
                          titleWidget("Itens"),
                          SizedBox(width: 16),
                          Observer(
                            builder: (_) => Visibility(
                              visible: !controller.pedidoRealizado,
                              child: TextButton(
                                child: Text("Alterar", style: theme.bodyText1.copyWith(color: PaletaCores.primaryLight)),
                                onPressed: controller.toProdutoPage,
                              ),
                            ),
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
                      descricaoWidget("Nome: ${controller.pedidoStore?.userVendedor?.nome ?? ""}"),
                      descricaoWidget("Empresa: ${controller.pedidoStore?.userVendedor?.empresa ?? ""}"),
                      descricaoWidget("Telefone: ${controller.pedidoStore?.userVendedor?.telefone ?? ""}"),
                      descricaoWidget("Email: ${controller.pedidoStore?.userVendedor?.email ?? ""}"),
                      //endregion

                      DefaultSizedBox(),

                      //region distancia
                      Observer(
                        builder: (_) => Visibility(
                          visible: controller.pedidoStore?.distance != null,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              titleWidget("Distância"),
                              SizedBox(height: 10),
                              descricaoWidget("${controller.pedidoStore?.distance?.toStringAsFixed(2) ?? ""} metros"),
                            ],
                          ),
                        ),
                      ),
                      //endregion

                      DefaultSizedBox(),
                    ],
                  ),
                ),
              ),
            ),
            Column(
              children: [
                Visibility(
                  visible: !controller.pedidoRealizado,
                  child: GradienteButton(
                    child: IconTextWidget(
                      text: "Enviar Pedido",
                      icon: Icons.send,
                      color: Colors.white,
                    ),
                    colors: PaletaCores.gradiente,
                    onPressed: () async {
                      try {
                        await controller.save();
                      } catch (e) {
                        AlertDialogWidget.show(context, title: "Alerta!", content: "$e");
                      }
                    },
                  ),
                ),
                Row(
                  children: [
                    Observer(
                      builder: (_) => Visibility(
                        visible: controller.appController.userStore.isVendedor && controller.pedidoRealizado && controller.pedidoStore.statusPedido == EnumStatusPedido.EmAberto || controller.pedidoStore.statusPedido == EnumStatusPedido.Aceito,
                        child: Expanded(
                          child: OutlinedButton(
                            onPressed: controller.cancelarPedido,
                            style: OutlinedButton.styleFrom(side: BorderSide(color: PaletaCores.primaryLight)),
                            child: Text("CANCELAR", style: TextStyle(fontSize: 16)),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                    Observer(builder: (_) {
                      if (controller.appController.userStore.isVendedor && controller.pedidoRealizado && controller.nextStatusPedido != null)
                        return Expanded(
                          child: GradienteButton(
                            child: Text(
                              EnumStatusPedidoHelper.description(controller.nextStatusPedido ?? 1).toUpperCase(),
                              style: TextStyle(color: Colors.white, fontSize: 16),
                            ),
                            colors: PaletaCores.gradiente,
                            onPressed: controller.atualizarStatus,
                          ),
                        );
                      else
                        return Container();
                    }),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
