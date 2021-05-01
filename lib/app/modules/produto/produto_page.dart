import 'package:beach_service/app/app_widget.dart';
import 'package:beach_service/app/modules/produto/dtos/categoria_dto.dart';
import 'package:beach_service/app/modules/produto/dtos/produto_dto.dart';
import 'package:beach_service/app/modules/produto/produto_controller.dart';
import 'package:beach_service/app/shared/components/bar.dart';
import 'package:beach_service/app/shared/components/button/gradiente_button.dart';
import 'package:beach_service/app/shared/components/button/rounded_button.dart';
import 'package:beach_service/app/shared/components/icon_text_widget.dart';
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
  PageController _pageController = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();

    _init();
  }

  Future<void> _init() async {
    await controller.load();
    listTest = List.generate(30, (index) => "Item $index");
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    // Theme para Button da AppBar
    final themeAppBar = theme.appBarTheme.textTheme.headline6.copyWith(fontSize: 18, fontWeight: FontWeight.bold);
    final style = themeAppBar.copyWith(color: Colors.grey);
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Observer(
              builder: (_) {
                return TextButton(
                    child: Text("Selecionar", style: controller.pageController == 0 ? themeAppBar : style),
                    onPressed: () {
                      _pageController.animateToPage(0, duration: Duration(milliseconds: 200), curve: Curves.linear);
                      controller.setPageController(0);
                    }
                );
              }
            ),
            Observer(
              builder: (_) {
                return TextButton(
                    child: Text("Meus Produtos", style: controller.pageController == 1 ? themeAppBar : style),
                    onPressed: () {
                      _pageController.animateToPage(1, duration: Duration(milliseconds: 200), curve: Curves.linear);
                      controller.setPageController(1);
                    }
                );
              }
            ),
          ],
        ),
      ),
      body: PageView(
        controller: _pageController,
        physics: BouncingScrollPhysics(),
        allowImplicitScrolling: true,
        children: [_listaProdutosPage(theme), Container()],
      ),
    );
  }

  Widget _listaProdutosPage(ThemeData theme) {
    return Column(
      children: [
        Bar(
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: ListView.builder(
              itemCount: controller.categoriasAll?.length ?? 0,
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, index) {
                CategoriaDto catIndex = controller.categoriasAll[index];

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6.0),
                  child: Center(
                    child: Observer(
                      builder: (_) => RoundedButton(
                        background: controller.categoriaFiltro.base.id == catIndex.base.id ? Colors.white38 : Colors.transparent,
                        borderColor: Colors.white,
                        child: Text(
                          catIndex.descricao,
                          style: TextStyle(color: Colors.white),
                        ),
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
                child: Padding(
                  padding: DefaultPadding.paddingList,
                  child: Observer(
                    builder: (_) => ListView.separated(
                      separatorBuilder: (_, __) => Container(height: 0.5, color: Colors.grey[300]),
                      itemCount: controller.produtosFiltrados.length,
                      itemBuilder: (_, index) {
                        ProdutoDto produto = controller.produtosFiltrados[index];

                        return Observer(builder: (_) {
                          bool isSelected = controller.isSelect(produto);
                          return ListTile(
                            title: Text(
                              "${produto.descricao}",
                              style: isSelected ? theme.textTheme.bodyText1.copyWith(color: PaletaCores.primaryLight) : theme.textTheme.bodyText1,
                            ),
                            trailing: Visibility(
                              visible: isSelected,
                              child: Icon(
                                Icons.check,
                                color: PaletaCores.primaryLight,
                              ),
                            ),
                            contentPadding: EdgeInsets.symmetric(horizontal: 10),
                            onTap: () {
                              if (isSelected)
                                controller.removeProdutosSelect(produto);
                              else
                                controller.setProdutosSelect(produto);
                            },
                          );
                        });
                      },
                    ),
                  ),
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
    );
  }
}
