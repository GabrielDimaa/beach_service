import 'package:beach_service/app/app_widget.dart';
import 'package:beach_service/app/modules/user/pages/user_controller.dart';
import 'package:beach_service/app/shared/components/avatar/avatar_widget.dart';
import 'package:beach_service/app/shared/components/button/gradiente_button.dart';
import 'package:beach_service/app/shared/components/categorias_tile.dart';
import 'package:beach_service/app/shared/defaults/default_padding.dart';
import 'package:beach_service/app/shared/defaults/default_sized_box.dart';
import 'package:flutter/cupertino.dart';
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
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 36),
                child: Column(
                  children: [
                    AvatarWidget(
                      iconColor: Colors.white,
                      backgroundColor: PaletaCores.primary,
                    ),
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
                        Expanded(child: _estatisticas(title: "Vendas", numeros: "154", theme: theme)),
                        Container(
                          height: 50,
                          child: VerticalDivider(width: 2, color: Colors.black),
                        ),
                        Expanded(child: _estatisticas(title: "Avaliações", numeros: "127", theme: theme)),
                      ],
                    ),
                    DefaultSizedBox(),
                    Wrap(
                      alignment: WrapAlignment.center,
                      children: [
                        CategoriasTile(
                          label: "Bebidas",
                          margin: EdgeInsets.all(4),
                        ),
                        CategoriasTile(label: "Bazar", margin: EdgeInsets.all(4)),
                        CategoriasTile(label: "Gelados", margin: EdgeInsets.all(4)),
                        CategoriasTile(label: "Salgados", margin: EdgeInsets.all(4)),
                      ],
                    ),
                    DefaultSizedBox(),
                    Expanded(
                      child: ListView.builder(
                          itemCount: 20,
                          itemBuilder: (_, index) {
                            return ListTile(
                              title: Text(
                                "produto $index",
                                style: theme.textTheme.bodyText1,
                              ),
                              contentPadding: EdgeInsets.symmetric(horizontal: 10),
                            );
                          },
                        ),
                      ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: DefaultPadding.paddingButtonBottom,
              child: GradienteButton(
                child: Text(
                  "FAZER PEDIDO",
                  style: theme.textTheme.bodyText2,
                ),
                colors: PaletaCores.gradiente,
              ),
            ),
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
