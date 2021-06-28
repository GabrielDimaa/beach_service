import 'package:beach_service/app/app_controller.dart';
import 'package:beach_service/app/shared/components/avatar/avatar_widget.dart';
import 'package:beach_service/app/shared/components/bar.dart';
import 'package:beach_service/app/shared/components/dialog/alert_dialog_widget.dart';
import 'package:beach_service/app/shared/components/drawer/item_drawer.dart';
import 'package:beach_service/app/shared/constants/page.dart';
import 'package:beach_service/app/shared/defaults/default_sized_box.dart';
import 'package:beach_service/app/shared/preferences/auth_preferences.dart';
import 'package:beach_service/app/shared/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class DrawerWidget extends StatelessWidget {
  final AppController appController = Modular.get<AppController>();

  EdgeInsets get padding => EdgeInsets.all(16);

  Future<void> _logout() async {
    await AuthPreferences().delete();
    Modular.to.navigate("/$LOGIN_ROUTE");
  }

  @override
  Widget build(BuildContext context) {
    TextTheme theme = Theme.of(context).textTheme;
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(52),
        bottomRight: Radius.circular(52),
      ),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.65,
        child: Drawer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Bar(
                height: 220,
                margin: EdgeInsets.all(0),
                child: Padding(
                  padding: padding,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AvatarWidget(),
                        ],
                      ),
                      DefaultSizedBox(),
                      Text(appController.userStore.nome, style: theme.bodyText2.copyWith(fontSize: 16, fontWeight: FontWeight.bold)),
                      Text(appController.userStore.email, style: theme.bodyText2.copyWith(fontSize: 16)),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    ItemDrawer(
                      icon: Icons.home,
                      label: "Home",
                      isSelected: appController.page == HOME_PAGE,
                      onTap: () {
                        appController.setPage(HOME_PAGE);
                        Modular.to.navigate("/$HOME_ROUTE");
                      },
                    ),
                    Visibility(
                      visible: appController.userStore.isVendedor,
                      child: ItemDrawer(
                        icon: Icons.rv_hookup,
                        label: "Meus Produtos",
                        isSelected: appController.page == PRODUTO_PAGE,
                        onTap: () {
                          appController.setPage(PRODUTO_PAGE);
                          Modular.to.navigate("/$PRODUTO_ROUTE");
                        },
                      ),
                    ),
                    ItemDrawer(
                      icon: Icons.person,
                      label: "Minha Conta",
                      isSelected: appController.page == MINHA_CONTA_PAGE,
                      onTap: () {
                        appController.setPage(MINHA_CONTA_PAGE);
                        Modular.to.navigate("/$USER_ROUTE");
                      },
                    ),
                    ItemDrawer(
                      icon: Icons.ballot,
                      label: "Pedidos",
                      isSelected: appController.page == PEDIDOS_PAGE,
                      onTap: () {
                        appController.setPage(PEDIDOS_PAGE);
                        Modular.to.navigate('/$PEDIDO_ROUTE/$PEDIDO_BUSCA_ROUTE');
                      },
                    ),
                    ItemDrawer(
                      icon: Icons.notifications,
                      label: "Avisos",
                      isSelected: appController.page == AVISOS_PAGE,
                      onTap: () => AlertDialogWidget.show(context, content: "Não clica aí meu, vai explodir teu celular!"),
                    ),
                    ItemDrawer(
                      icon: Icons.settings,
                      label: "Configurações",
                      isSelected: appController.page == CONFIG_PAGE,
                      onTap: () => AlertDialogWidget.show(context, content: "Não clica aí meu, vai explodir teu celular!"),
                    ),
                  ],
                ),
              ),
              ItemDrawer(
                icon: Icons.logout,
                label: "Sair",
                onTap: _logout,
              ),
              DefaultSizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
