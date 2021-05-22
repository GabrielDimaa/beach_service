import 'package:beach_service/app/app_widget.dart';
import 'package:beach_service/app/modules/produto/dtos/categoria_dto.dart';
import 'package:beach_service/app/modules/user/dtos/user_prod_dto.dart';
import 'package:beach_service/app/shared/components/avatar/avatar_widget.dart';
import 'package:beach_service/app/shared/components/button/gradiente_button.dart';
import 'package:diacritic/diacritic.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

    categorias.addAll(_getCategorias());
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
                  backgroundColor: PaletaCores.light,
                  iconColor: Colors.white,
                ),
                Expanded(
                  child: ListTile(
                    title: Text(widget.userProdDto.nome, style: theme.textTheme.bodyText1),
                    subtitle: Text(widget.userProdDto.empresa),
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
                      "500M",
                      style: theme.textTheme.bodyText1.copyWith(fontSize: 12),
                    )
                  ],
                ),
              ],
            ),
            SizedBox(height: 10),
            Container(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categorias.length,
                itemBuilder: (_, index) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    margin: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: PaletaCores.light, width: 2),
                    ),
                    child: Center(
                      child: Text(
                        categorias[index].descricao,
                        style: theme.textTheme.bodyText1.copyWith(color: PaletaCores.light, fontSize: 14),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 10),
            GradienteButton(
              onPressed: () {},
              width: MediaQuery.of(context).size.width * 0.5,
              colors: PaletaCores.gradiente,
              child: Text("Visualizar perfil"),
            ),
          ],
        ),
      ),
    );
  }

  List<CategoriaDto> _getCategorias() {
    List<CategoriaDto> categorias = [];
    this.categorias.clear();

    widget.userProdDto.produtos.forEach((e) {
      if (!categorias.any((element) => element.base.id == e.categoriaDto.base.id)) categorias.add(e.categoriaDto);
    });

    categorias.sort((a, b) => removeDiacritics(a.descricao?.toLowerCase()).compareTo(b.descricao?.toLowerCase()));

    return categorias;
  }
}
