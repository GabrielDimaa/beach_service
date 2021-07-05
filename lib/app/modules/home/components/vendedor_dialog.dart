import 'package:beach_service/app/app_widget.dart';
import 'package:beach_service/app/modules/produto/dtos/categoria_dto.dart';
import 'package:beach_service/app/modules/user/dtos/user_prod_dto.dart';
import 'package:beach_service/app/shared/components/avatar/avatar_widget.dart';
import 'package:beach_service/app/shared/components/button/gradiente_button.dart';
import 'package:beach_service/app/shared/components/categorias_tile.dart';
import 'package:beach_service/app/shared/defaults/default_sized_box.dart';
import 'package:beach_service/app/shared/routes/routes.dart';
import 'package:beach_service/app/shared/utils/produtos_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class VendedorDialog extends StatefulWidget {
  final UserProdDto userProdDto;

  const VendedorDialog({Key key, this.userProdDto}) : super(key: key);

  @override
  _VendedorDialogState createState() => _VendedorDialogState();

  static Future show(BuildContext context, {UserProdDto userProdDto}) async {
    await showDialog(
      context: context,
      builder: (_) => VendedorDialog(
        userProdDto: userProdDto,
      ),
    );
  }
}

class _VendedorDialogState extends State<VendedorDialog> {
  List<CategoriaDto> categorias = [];

  @override
  void initState() {
    super.initState();

    categorias.clear();
    categorias.addAll(ProdutosUtils.getCategorias(widget.userProdDto.produtos));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                AvatarWidget(
                  backgroundColor: PaletaCores.primary,
                  iconColor: Colors.white,
                  circleSize: 52,
                  iconSize: 32,
                ),
                Expanded(
                  child: ListTile(
                    title: Text(widget.userProdDto.nome, style: theme.textTheme.bodyText1),
                    subtitle: Text(widget.userProdDto.empresa ?? ""),
                  ),
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.star, color: PaletaCores.primary),
                        Icon(Icons.star, color: PaletaCores.primary),
                        Icon(Icons.star, color: PaletaCores.primary),
                      ],
                    ),
                    Text(
                      "${widget.userProdDto.distance.toStringAsFixed(2)} metros",
                      style: theme.textTheme.bodyText1.copyWith(fontSize: 12),
                    )
                  ],
                ),
              ],
            ),
            DefaultSizedBox(),
            Wrap(
              alignment: WrapAlignment.center,
              children: categorias.map((e) {
                return CategoriasTile(
                  label: e.descricao,
                  margin: EdgeInsets.all(4),
                );
              }).toList(),
            ),
            SizedBox(height: 50),
            GradienteButton(
              onPressed: () async {
                Modular.to.pop();
                Modular.to.pushNamed("/$USER_ROUTE", arguments: widget.userProdDto);
              },
              width: MediaQuery.of(context).size.width * 0.5,
              colors: PaletaCores.gradiente,
              child: Text("Visualizar perfil"),
            ),
          ],
        ),
      ),
    );
  }
}
