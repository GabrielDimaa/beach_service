import 'package:beach_service/app/app_widget.dart';
import 'package:beach_service/app/modules/user/dtos/user_prod_dto.dart';
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
  final UserProdDto userProdDto;

  const UserPage({Key key, this.userProdDto}) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends ModularState<UserPage, UserController> {
  @override
  void initState() {
    super.initState();

    controller.load(widget.userProdDto);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: theme.iconTheme.copyWith(color: PaletaCores.light),
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
                    Text(controller.userProdStore.nome, style: theme.textTheme.headline1.copyWith(color: Colors.black, fontSize: 28)),
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
                      children: _categorias(),
                    ),
                    DefaultSizedBox(),
                    Expanded(
                      child: ListView.builder(
                        itemCount: controller.userProdStore?.produtos?.length ?? 0,
                        itemBuilder: (_, index) {
                          return ListTile(
                            title: Text(controller.userProdStore.produtos[index].descricao, style: theme.textTheme.bodyText1),
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

  List<Widget> _categorias() {
    List<Widget> widgets = [];

    controller.categorias.forEach((element) {
      widgets.add(CategoriasTile(label: element.descricao, margin: EdgeInsets.all(4)));
    });

    return widgets;
  }
}
