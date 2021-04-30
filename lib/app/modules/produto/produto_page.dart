import 'package:beach_service/app/app_widget.dart';
import 'package:beach_service/app/modules/produto/dtos/categoria_dto.dart';
import 'package:beach_service/app/modules/produto/produto_controller.dart';
import 'package:beach_service/app/shared/components/bar.dart';
import 'package:beach_service/app/shared/components/button/gradiente_button.dart';
import 'package:beach_service/app/shared/components/button/rounded_button.dart';
import 'package:beach_service/app/shared/components/icon_text_widget.dart';
import 'package:beach_service/app/shared/components/list/list_separated.dart';
import 'package:beach_service/app/shared/defaults/default_padding.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ProdutoPage extends StatefulWidget {
  @override
  ProdutoPageState createState() => ProdutoPageState();
}

class ProdutoPageState extends ModularState<ProdutoPage, ProdutoController> {
  List<String> listTest;

  @override
  void initState() {
    super.initState();

    listTest = List.generate(30, (index) => "Item $index");
    controller.load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Escolha o que vender")),
      body: Column(
        children: [
          Bar(
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: ListView.builder(
                itemCount: controller.categoriasAll?.length ?? 0,
                scrollDirection: Axis.horizontal,
                itemBuilder: (_, index) {
                  CategoriaDto catIndex= controller.categoriasAll[index];

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6.0),
                    child: Center(
                      child: Observer(
                        builder: (_) => RoundedButton(
                          background: controller.categoriaFiltro.base.id == catIndex.base.id ? Colors.white38 : Colors.transparent,
                          borderColor: Colors.white,
                          child: Text(catIndex.descricao, style: TextStyle(color: Colors.white),),
                          onPressed: () => controller.setCategoriaFiltro(catIndex),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: ListSeparated(
                    list: listTest,
                    isSelected: false,
                    onTap: () {},
                  ),
                ),
                Padding(
                  padding: DefaultPadding.paddingButtonBottom,
                  child: GradienteButton(
                    onPressed: () {},
                    child: IconTextWidget(
                      text: "SALVAR",
                      icon: Icons.save,
                      color: Colors.white,
                    ),
                    colors: PaletaCores.gradiente,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
