import 'package:beach_service/app/app_widget.dart';
import 'package:beach_service/app/modules/home/home_store.dart';
import 'package:beach_service/app/modules/user/dtos/user_dto.dart';
import 'package:beach_service/app/modules/user/enums/enum_tipo_user.dart';
import 'package:beach_service/app/shared/defaults/default_padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomePage extends StatefulWidget {
  final String title;
  final UserDto dto;

  const HomePage({Key key, this.title = "Home", this.dto}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeStore> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Counter'),
      ),
      body: Padding(
        padding: DefaultPadding.paddingScaffold,
        child: Center(
          child: Column(
            children: [
              _row("ID", "${widget.dto.base.id}"),
              _row("NOME", "${widget.dto.nome}"),
              _row("EMAIL", "${widget.dto.email}"),
              _row("TELEFONE", "${widget.dto.telefone}"),
              _row("CEP", "${widget.dto.cep}"),
              _row("TIPO DE USER", "${EnumTipoUserHelper.getValue(widget.dto.tipoUser)}"),
              _row("EMPRESA", "${widget.dto.empresa ?? ""}"),
            ],
          ),
        ),
      ),
    );
  }

  Widget _row(String left, String right) {
    TextStyle style = TextStyle(color: PaletaCores.primaryLight, fontSize: 16, fontWeight: FontWeight.bold);
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [Text(left, style: style), Text(right, style: style,)],
    );
  }
}
