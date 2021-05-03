import 'package:beach_service/app/app_widget.dart';
import 'package:beach_service/app/modules/produto/dtos/categoria_dto.dart';
import 'package:beach_service/app/modules/produto/dtos/produto_dto.dart';
import 'package:beach_service/app/modules/produto/produto_controller.dart';
import 'package:beach_service/app/shared/components/bar.dart';
import 'package:beach_service/app/shared/components/button/gradiente_button.dart';
import 'package:beach_service/app/shared/components/button/rounded_button.dart';
import 'package:beach_service/app/shared/components/dialog/alert_dialog_widget.dart';
import 'package:beach_service/app/shared/components/icon_text_widget.dart';
import 'package:beach_service/app/shared/defaults/default_padding.dart';
import 'package:beach_service/app/shared/defaults/default_sized_box.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ProdutoPage extends StatefulWidget {
  @override
  ProdutoPageState createState() => ProdutoPageState();
}

class ProdutoPageState extends ModularState<ProdutoPage, ProdutoController> {
  PageController _pageController;

  @override
  void initState() {
    super.initState();

    _init();

    _pageController = PageController(initialPage: controller.pageController);
  }

  Future<void> _init() async {
    await controller.load();
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
            Observer(builder: (_) {
              return TextButton(
                  child: Text("Selecionar", style: controller.pageController == 0 ? themeAppBar : style),
                  onPressed: () {
                    _pageController.animateToPage(0, duration: Duration(milliseconds: 200), curve: Curves.linear);
                    controller.setPageController(0);
                  });
            }),
            Observer(builder: (_) {
              return TextButton(
                  child: Text("Meus Produtos", style: controller.pageController == 1 ? themeAppBar : style),
                  onPressed: () {
                    _pageController.animateToPage(1, duration: Duration(milliseconds: 200), curve: Curves.linear);
                    controller.setPageController(1);
                  });
            }),
          ],
        ),
        titleSpacing: 0,
        iconTheme: theme.iconTheme.copyWith(color: PaletaCores.primaryLight),
      ),
      body: PageView(
        controller: _pageController,
        physics: BouncingScrollPhysics(),
        allowImplicitScrolling: true,
        onPageChanged: (int page) => controller.setPageController(page),
        children: [
          _listaProdutosPage(context, theme),
          _meusProdutosPage(context, theme),
        ],
      ),
    );
  }

  Widget _listaProdutosPage(BuildContext context, ThemeData theme) {
    return Column(
      children: [
        Bar(
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Observer(
              builder: (_) => ListView.builder(
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
        ),
        Expanded(
          child: Padding(
            padding: DefaultPadding.paddingList,
            child: Column(
              children: [
                Expanded(
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
                DefaultSizedBox(),
                _bottomButton(context),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _meusProdutosPage(BuildContext context, ThemeData theme) {
    return Padding(
      padding: DefaultPadding.paddingList,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Meus Produtos", style: theme.textTheme.headline4),
                    ),
                    DefaultSizedBox(),
                    Expanded(
                      child: Observer(
                        builder: (_) => ListView.builder(
                          itemCount: controller.produtosSelect.length,
                          itemBuilder: (_, index) {
                            ProdutoDto produto = controller.produtosSelect[index];

                            return ListTile(
                              contentPadding: EdgeInsets.all(0),
                              title: Text(produto.descricao, style: theme.textTheme.bodyText1),
                              subtitle: Text(produto.categoriaDto.descricao),
                              trailing: IconButton(
                                icon: Icon(Icons.cancel_outlined),
                                onPressed: () => controller.removeProdutosSelect(produto),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          DefaultSizedBox(),
          _bottomButton(context),
        ],
      ),
    );
  }

  Widget _bottomButton(BuildContext context) {
    return GradienteButton(
      onPressed: () async {
        try {
          await controller.save();
        } catch(e) {
          AlertDialogWidget.show(context, content: "$e");
        }
      },
      child: IconTextWidget(
        text: "SALVAR",
        icon: Icons.save,
        color: Colors.white,
      ),
      colors: PaletaCores.gradiente,
    );
  }
}
