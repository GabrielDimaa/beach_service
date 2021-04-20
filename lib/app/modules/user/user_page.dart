import 'package:beach_service/app/app_widget.dart';
import 'package:beach_service/app/shared/components/app_bar/app_bar_title.dart';
import 'package:beach_service/app/shared/components/icon_text_widget.dart';
import 'package:beach_service/app/shared/components/scaffold_widget.dart';
import 'package:beach_service/app/shared/defaults/default_sized_box.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UserPage extends StatefulWidget {
  final String title;

  const UserPage({Key key, this.title = "Cadastro"}) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {

  //TextEditingControllers
  final TextEditingController _controllerNome = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerSenha = TextEditingController();
  final TextEditingController _controllerCidade = TextEditingController();
  final TextEditingController _controllerDataNascimento = TextEditingController();
  final TextEditingController _controllerTelefone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  AppBarTitleWidget(title: widget.title),
                  GestureDetector(
                    onTap: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 50,
                          child: Icon(Icons.person, color: PaletaCores.primaryLight, size: 86),
                        ),
                        Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white,
                            ),
                            child: Icon(Icons.add, color: PaletaCores.primaryLight)),
                      ],
                    ),
                  ),
                  DefaultSizedBox(),
                  DefaultSizedBox(),
                  Form(
                    child: Column(
                      children: [
                        _textFormField(label: "Nome completo", keyboardType: TextInputType.name),
                        DefaultSizedBox(),
                        _textFormField(label: "Email", keyboardType: TextInputType.emailAddress),
                        DefaultSizedBox(),
                        _textFormField(label: "Senha", obscure: true),
                        DefaultSizedBox(),
                        _textFormField(label: "Cidade"),
                        DefaultSizedBox(),
                        _textFormField(label: "Data de nascimento", keyboardType: TextInputType.number, controller: _controllerDataNascimento, inputFormatter: [
                          FilteringTextInputFormatter.digitsOnly,
                          DataInputFormatter(),
                        ]),
                        DefaultSizedBox(),
                        _textFormField(
                          label: "Telefone",
                          keyboardType: TextInputType.phone,
                          inputFormatter: [
                            FilteringTextInputFormatter.digitsOnly,
                            TelefoneInputFormatter(),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              child: IconTextWidget(text: "REGISTRAR", icon: Icons.save),
            ),
          ),
        ],
      ),
    );
  }

  Widget _textFormField({
    String label,
    TextEditingController controller,
    bool obscure = false,
    TextInputType keyboardType = TextInputType.text,
    List<TextInputFormatter> inputFormatter,
  }) {
    return TextFormField(
      controller: controller,
      cursorColor: Colors.white,
      style: TextStyle(color: Colors.white, fontSize: 18),
      obscureText: obscure,
      keyboardType: keyboardType,
      inputFormatters: inputFormatter,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(bottom: 8),
        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white54)),
        enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white24)),
        labelText: label,
        labelStyle: TextStyle(fontSize: 18, color: Colors.white54),
      ),
    );
  }
}
