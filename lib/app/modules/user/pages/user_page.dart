import 'package:beach_service/app/app_widget.dart';
import 'package:beach_service/app/modules/user/user_controller.dart';
import 'package:beach_service/app/shared/components/app_bar/app_bar_title.dart';
import 'package:beach_service/app/shared/components/busca_widget.dart';
import 'package:beach_service/app/shared/components/form/text_form_field_widget.dart';
import 'package:beach_service/app/shared/components/form/validator.dart';
import 'package:beach_service/app/shared/components/icon_text_widget.dart';
import 'package:beach_service/app/shared/components/scaffold_widget.dart';
import 'package:beach_service/app/shared/defaults/default_sized_box.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:beach_service/app/shared/extensions/date_extension.dart';
import 'package:flutter_modular/flutter_modular.dart';

class UserPage extends StatefulWidget {
  final String title;

  const UserPage({Key key, this.title = "Cadastro"}) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends ModularState<UserPage, UserController> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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

    _updateTextControllers();
  }

  void _updateTextControllers() {
    _controllerNome.text = controller.userStore?.nome ?? "";
    _controllerEmail.text = controller.userStore?.email ?? "";
    _controllerPassword.text = controller.userStore?.password ?? "";
    _controllerCep.text = controller.userStore?.cep ?? "";
    _controllerDataNascimento.text = controller.userStore?.dataNascimento ?? "";
    _controllerTelefone.text = controller.userStore?.telefone ?? "";
  }

  Future<void> _save() async {
    try {
      if (_formKey.currentState.validate()) {
        _formKey.currentState.save();
        await controller.save();
      }
    } catch (e) {
      print("ERRO SAVE");
    }
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
                  _form(),
                ],
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: ElevatedButton(
                onPressed: _save,
                child: IconTextWidget(text: "REGISTRAR", icon: Icons.save),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _form() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormFieldWidget(
            label: "Nome completo",
            controller: _controllerNome,
            keyboardType: TextInputType.name,
            onSaved: controller.userStore.setNome,
            validator: InputValidator(DefaultValidator("Nome")).validate,
          ),
          DefaultSizedBox(),
          TextFormFieldWidget(
            label: "Email",
            controller: _controllerEmail,
            keyboardType: TextInputType.emailAddress,
            onSaved: controller.userStore.setEmail,
            validator: InputValidator(EmailValidator()).validate,
          ),
          DefaultSizedBox(),
          TextFormFieldWidget(
            label: "Senha",
            controller: _controllerPassword,
            obscure: true,
            onSaved: controller.userStore.setPassword,
            validator: InputValidator(PasswordValidator()).validate,
          ),
          DefaultSizedBox(),
          TextFormFieldWidget(
            label: "CEP",
            controller: _controllerCep,
            onSaved: controller.userStore.setCep,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              CepInputFormatter(),
            ],
            validator: InputValidator(CepValidator()).validate,
          ),
          DefaultSizedBox(),
          TextFormFieldWidget(
            label: "Telefone",
            controller: _controllerTelefone,
            keyboardType: TextInputType.phone,
            onSaved: controller.userStore.setTelefone,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              TelefoneInputFormatter(),
            ],
            validator: InputValidator(TelefoneValidator()).validate,
          ),
          DefaultSizedBox(),
          BuscaWidget(
            label: "Data de nascimento",
            textEditingController: _controllerDataNascimento,
            validator: InputValidator(DefaultValidator("Data de Nascimento")).validate,
            onTapFormField: () async {
              DateTime data = await showDatePicker(
                context: context,
                initialDate: DateTime.utc(2000, 1, 1),
                firstDate: DateTime(1910, 1, 1),
                lastDate: DateTime(2005, 12, 31),
              );
              setState(() {
                controller.userStore.setDataNascimento(data);
                _controllerDataNascimento.text = data.formated ?? "";
              });
            },
            onTapClear: () {
              setState(() {
                controller.userStore.setDataNascimento(null);
                _controllerDataNascimento.clear();
              });
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controllerNome.dispose();
    _controllerEmail.dispose();
    _controllerPassword.dispose();
    _controllerCep.dispose();
    _controllerDataNascimento.dispose();
    _controllerTelefone.dispose();
    super.dispose();
  }
}