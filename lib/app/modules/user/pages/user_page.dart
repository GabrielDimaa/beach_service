import 'package:beach_service/app/app_widget.dart';
import 'package:beach_service/app/modules/user/pages/user_controller.dart';
import 'package:beach_service/app/shared/components/avatar/avatar_widget.dart';
import 'package:beach_service/app/shared/components/button/gradiente_button.dart';
import 'package:beach_service/app/shared/defaults/default_sized_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class UserPage extends StatefulWidget {
  final bool isPerfilPessoal;

  const UserPage({Key key, this.isPerfilPessoal = false}) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends ModularState<UserPage, UserController> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: [
          Visibility(
            //visible: widget.isPerfilPessoal,
            child: IconButton(
              icon: Icon(Icons.edit, color: PaletaCores.light),
              onPressed: () {},
            ),
          ),
        ],
      ),
      //drawer: DrawerWidget(),
      body: Align(
        alignment: Alignment.center,
        child: Column(
          children: [
            AvatarWidget(iconColor: Colors.white, backgroundColor: PaletaCores.primary,),
            SizedBox(height: 10),
            Text("Gabriel de Matos", style: theme.textTheme.headline1.copyWith(color: Colors.black, fontSize: 28)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.star, color: PaletaCores.primary),
                Icon(Icons.star, color: PaletaCores.primary),
                Icon(Icons.star, color: PaletaCores.primary),
              ],
            ),
            DefaultSizedBox(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _estatisticas(title: "Vendas", numeros: "154", theme: theme),
                Container(height: 50, child: VerticalDivider(width: 2, color: Colors.black,)),
                _estatisticas(title: "Avaliações", numeros: "127", theme: theme),
              ],
            ),
            DefaultSizedBox(),
            GradienteButton(child: Text("dskjn", style: theme.textTheme.bodyText2,), colors: PaletaCores.gradiente,),
          ],
        ),
      ),
    );
  }

  Widget _estatisticas({String numeros, String title, ThemeData theme}) {
    return Column(
      children: [
        Column(
          children: [
            Text(numeros ?? 0, style: theme.textTheme.bodyText2.copyWith(color: Colors.black, fontSize: 22)),
            Text(title, style: theme.textTheme.bodyText2.copyWith(color: Colors.black)),
          ],
        ),
      ],
    );
  }
}
