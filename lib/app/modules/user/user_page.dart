import 'package:beach_service/app/app_widget.dart';
import 'package:beach_service/app/shared/components/app_bar/app_bar_title.dart';
import 'package:beach_service/app/shared/components/busca_widget.dart';
import 'package:beach_service/app/shared/components/icon_text_widget.dart';
import 'package:beach_service/app/shared/components/scaffold_widget.dart';
import 'package:beach_service/app/shared/components/text_form_field_widget.dart';
import 'package:beach_service/app/shared/defaults/default_sized_box.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:beach_service/app/shared/extensions/date_extension.dart';

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
  final TextEditingController _controllerPassword = TextEditingController();
  final TextEditingController _controllerCep = TextEditingController();
  final TextEditingController _controllerDataNascimento = TextEditingController();
  final TextEditingController _controllerTelefone = TextEditingController();

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() {
    // Update TextEditingController
  }

  @override
  Widget build(BuildContext context) {
    final bottomScroll = MediaQuery.of(context).viewInsets.bottom;
    return ScaffoldWidget(
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              reverse: true,
              padding: EdgeInsets.only(bottom: bottomScroll ?? 0),
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
                          child: Icon(Icons.add, color: PaletaCores.primaryLight),
                        ),
                      ],
                    ),
                  ),
                  DefaultSizedBox(),
                  DefaultSizedBox(),
                  Form(
                    child: Column(
                      children: [
                        TextFormFieldWidget(
                          label: "Nome completo",
                          keyboardType: TextInputType.name,
                          controller: _controllerNome,
                        ),
                        DefaultSizedBox(),
                        TextFormFieldWidget(
                          label: "Email",
                          keyboardType: TextInputType.emailAddress,
                          controller: _controllerEmail,
                        ),
                        DefaultSizedBox(),
                        TextFormFieldWidget(
                          label: "Senha",
                          obscure: true,
                          controller: _controllerPassword,
                        ),
                        DefaultSizedBox(),
                        TextFormFieldWidget(
                          label: "CEP",
                          controller: _controllerCep,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            CepInputFormatter(),
                          ],
                        ),
                        DefaultSizedBox(),
                        TextFormFieldWidget(
                          label: "Telefone",
                          keyboardType: TextInputType.phone,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            TelefoneInputFormatter(),
                          ],
                        ),
                        DefaultSizedBox(),
                        BuscaWidget(
                          label: "Data de nascimento",
                          textEditingController: _controllerDataNascimento,
                          onTapFormField: () async {
                            DateTime data = await showDatePicker(
                              context: context,
                              initialDate: DateTime.utc(2000, 1, 1),
                              firstDate: DateTime(1910, 1, 1),
                              lastDate: DateTime.now(),
                            );
                            setState(() {
                              //controller.setDataHora(data);
                              _controllerDataNascimento.text = data.formated ?? "";
                            });
                          },
                          onTapClear: () {
                            setState(() {
                              //controller.setFormaRecebimento(null);
                              _controllerDataNascimento.clear();
                            });
                          },
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
            child: Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: ElevatedButton(
                onPressed: () {},
                child: IconTextWidget(text: "REGISTRAR", icon: Icons.save),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
