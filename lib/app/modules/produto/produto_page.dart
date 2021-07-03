import 'package:beach_service/app/app_widget.dart';
import 'package:beach_service/app/modules/produto/dtos/categoria_dto.dart';
import 'package:beach_service/app/modules/produto/dtos/produto_dto.dart';
import 'package:beach_service/app/modules/produto/produto_controller.dart';
import 'package:beach_service/app/shared/components/bar.dart';
import 'package:beach_service/app/shared/components/button/gradiente_button.dart';
import 'package:beach_service/app/shared/components/button/rounded_button.dart';
import 'package:beach_service/app/shared/components/dialog/alert_dialog_widget.dart';
import 'package:beach_service/app/shared/components/drawer/drawer_widget.dart';
import 'package:beach_service/app/shared/components/icon_text_widget.dart';
import 'package:beach_service/app/shared/components/loading/loading.dart';
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
    controller.setContext(context);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    // Theme para Button da AppBar
    final themeAppBar = theme.appBarTheme.textTheme.headline6.copyWith(fontSize: 18, fontWeight: FontWeight.bold);
    final style = themeAppBar.copyWith(color: Colors.grey);
    return Observer(
      builder: (_) => Scaffold(
        drawer: controller.isDrawer ? null : DrawerWidget(),
        appBar: AppBar(
          title: Row(
            children: [
              Observer(builder: (_) {
                return TextButton(
                  child: Text(!controller.isPedido ? "Selecionar" : "Produtos", style: controller.pageController == 0 ? themeAppBar : style),
                  onPressed: () {
                    _pageController.animateToPage(0, duration: Duration(milliseconds: 200), curve: Curves.linear);
                    controller.setPageController(0);
                  },
                );
              }),
              Observer(builder: (_) {
                return TextButton(
                    child: Text("Resumo", style: controller.pageController == 1 ? themeAppBar : style),
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
        body: Observer(
          builder: (_) {
            return PageView(
              controller: _pageController,
              physics: BouncingScrollPhysics(),
              allowImplicitScrolling: true,
              onPageChanged: (int page) => controller.setPageController(page),
              children: [
                _listaProdutosPage(context, theme),
                _meusProdutosPage(context, theme),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _listaProdutosPage(BuildContext context, ThemeData theme) {
    return Stack(
      children: [
        Observer(
          builder: (_) => Visibility(
            visible: controller.loading,
            child: LoadingWidget(description: "Aguarde...\nSincronizando seus produtos."),
          ),
        ),
        Column(
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
                        builder: (_) => Visibility(
                          visible: !controller.loading,
                          child: ListView.separated(
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
                    DefaultSizedBox(),
                    _bottomButton(context),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _meusProdutosPage(BuildContext context, ThemeData theme) {
    return Stack(
      children: [
        Observer(
          builder: (_) => Visibility(
            visible: controller.loading,
            child: LoadingWidget(description: "Aguarde...\nSincronizando seus produtos."),
          ),
        ),
        Padding(
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
                          child: Text(!controller.isPedido ? "Meus Produtos" : "Resumo", style: theme.textTheme.headline4),
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
        ),
      ],
    );
  }

  Widget _bottomButton(BuildContext context) {
    return Observer(
      builder: (_) => GradienteButton(
        onPressed: !controller.loading
            ? () async {
                try {
                  if (!controller.isPedido) {
                    await controller.save();
                  } else {
                    await controller.avancarPedido();
                  }
                } catch (e) {
                  AlertDialogWidget.show(context, content: "$e");
                }
              }
            : null,
        child: IconTextWidget(
          text: !controller.isPedido ? "SALVAR" : "Confirmar itens",
          icon: Icons.save,
          color: Colors.white,
        ),
        colors: PaletaCores.gradiente,
      ),
    );
  }
}
