import 'package:beach_service/app/app_widget.dart';
import 'package:beach_service/app/modules/user/enums/enum_tipo_user.dart';
import 'package:beach_service/app/modules/user/user_controller.dart';
import 'package:beach_service/app/shared/components/app_bar/app_bar_title.dart';
import 'package:beach_service/app/shared/components/dialog/alert_dialog_widget.dart';
import 'package:beach_service/app/shared/components/icon_text_widget.dart';
import 'package:beach_service/app/shared/components/scaffold_widget.dart';
import 'package:beach_service/app/shared/defaults/default_sized_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class TipoUserPage extends StatefulWidget {
  final String title;

  const TipoUserPage({Key key, this.title = "Tipo de Conta"}) : super(key: key);

  @override
  TipoUserPageState createState() => TipoUserPageState();
}

class TipoUserPageState extends ModularState<TipoUserPage, UserController> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      body: Column(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Align(alignment: Alignment.center, child: AppBarTitleWidget(title: widget.title)),
                DefaultSizedBox(),
                DefaultSizedBox(),
                Observer(
                  builder: (_) => TextButton(
                    onPressed: () => controller.userStore.setTipoUser(EnumTipoUser.Consumidor),
                    child: IconTextWidget(icon: Icons.beach_access, text: "CONSUMIDOR", color: Colors.white),
                    style: ElevatedButton.styleFrom(
                      onPrimary: Colors.white,
                      primary: controller.userStore.isConsumidor ? PaletaCores.dark : Colors.transparent,
                      padding: EdgeInsets.all(16),
                      side: BorderSide(color: Colors.white),
                    ),
                  ),
                ),
                DefaultSizedBox(),
                Observer(
                  builder: (_) => TextButton(
                    onPressed: () => controller.userStore.setTipoUser(EnumTipoUser.Vendedor),
                    child: IconTextWidget(icon: Icons.rv_hookup, text: "VENDEDOR", color: Colors.white),
                    style: ElevatedButton.styleFrom(
                      onPrimary: Colors.white,
                      primary: controller.userStore.isVendedor ? PaletaCores.dark : Colors.transparent,
                      padding: EdgeInsets.all(16),
                      side: BorderSide(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              child: IconTextWidget(text: "AVANÇAR", icon: Icons.navigate_next),
              onPressed: () => controller.avancar(context),
            ),
          ),
        ],
      ),
    );
  }
}
