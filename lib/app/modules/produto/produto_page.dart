import 'package:beach_service/app/app_widget.dart';
import 'package:beach_service/app/shared/components/bar.dart';
import 'package:beach_service/app/shared/components/button/gradiente_button.dart';
import 'package:beach_service/app/shared/components/button/rounded_button.dart';
import 'package:beach_service/app/shared/components/icon_text_widget.dart';
import 'package:beach_service/app/shared/components/list/list_separated.dart';
import 'package:beach_service/app/shared/defaults/default_padding.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProdutoPage extends StatefulWidget {
  @override
  ProdutoPageState createState() => ProdutoPageState();
}

class ProdutoPageState extends State<ProdutoPage> {
  List<String> listTest;

  @override
  void initState() {
    super.initState();

    listTest = List.generate(30, (index) => "ITEM $index");
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text("Escolha o que vender")),
      body: Column(
        children: [
          Bar(
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: ListView.builder(
                itemCount: listTest.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (_, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6.0),
                    child: Center(
                      child: RoundedButton(
                        onSurface: Colors.white,
                        child: ,
                      ),
                      // TextButton(
                      //   style: ElevatedButton.styleFrom(
                      //     onSurface: Colors.white,
                      //     padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      //     shape: RoundedRectangleBorder(side: BorderSide(
                      //       color: Colors.white,
                      //       width: 0.7,
                      //     ), borderRadius: BorderRadius.circular(20)),
                      //   ),
                      //   child: Text("Item $index", style: TextStyle(color: Colors.white),),
                      // ),
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
                    isSelected: true,
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
