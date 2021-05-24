import 'package:beach_service/app/modules/login/login_controller.dart';
import 'package:beach_service/app/shared/components/button/default_button.dart';
import 'package:beach_service/app/shared/components/dialog/alert_dialog_widget.dart';
import 'package:beach_service/app/shared/components/form/text_form_field_widget.dart';
import 'package:beach_service/app/shared/components/form/validator.dart';
import 'package:beach_service/app/shared/components/icon_text_widget.dart';
import 'package:beach_service/app/shared/components/scaffold/scaffold_widget.dart';
import 'package:beach_service/app/shared/defaults/default_sized_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class LoginPage extends StatefulWidget {
  final String title;

  const LoginPage({Key key, this.title = "LoginPage"}) : super(key: key);

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends ModularState<LoginPage, LoginController> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  //TextEditingControllers
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  Future<void> _login(BuildContext context) async {
    try {
      if (_formKey.currentState.validate()) {
        _formKey.currentState.save();
        await controller.login(context);
      }
    } catch (e) {
      AlertDialogWidget.show(context, content: e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return ScaffoldWidget(
      padding: EdgeInsets.all(0),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _logoWidget(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 36),
              child: Column(
                children: [
                  Text("Bem Vindo", style: theme.textTheme.headline1),
                  DefaultSizedBox(),
                  _loginWidget(),
                  DefaultSizedBox(),
                  Text("Não tem conta? Registre-se!"),
                  DefaultSizedBox(),
                  _registrarWidget(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _logoWidget() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.30,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(bottom: Radius.elliptical(180, 230)),
        color: Colors.white,
      ),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: Image.asset('assets/images/logo.png', scale: 1.2),
          ),
        ],
      ),
    );
  }

  Widget _loginWidget() {
    return Column(
      children: [
        Form(
          key: _formKey,
          child: Column(
            children: [
              Observer(
                builder: (_) => TextFormFieldWidget(
                  label: "Email",
                  controller: _controllerEmail,
                  keyboardType: TextInputType.emailAddress,
                  enabled: !controller.loading,
                  onSaved: controller.loginStore.setEmail,
                  validator: InputValidator(EmailValidator()).validate,
                ),
              ),
              DefaultSizedBox(),
              Observer(
                builder: (_) => TextFormFieldWidget(
                  label: "Senha",
                  controller: _controllerPassword,
                  obscure: true,
                  enabled: !controller.loading,
                  onSaved: controller.loginStore.setPassword,
                  validator: InputValidator(PasswordValidator()).validate,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 8),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {},
            child: Text("Esqueceu a senha?"),
            style: ElevatedButton.styleFrom(onPrimary: Colors.white),
          ),
        ),
        SizedBox(height: 8),
        Observer(
          builder: (_) => Visibility(
            visible: controller.loading,
            child: LinearProgressIndicator(),
          ),
        ),
        Observer(
          builder: (_) => DefaultButton(
            onPressed: !controller.loading ? () => _login(context) : null,
            child: IconTextWidget(text: "ENTRAR", icon: Icons.login),
          ),
        ),
      ],
    );
  }

  Widget _registrarWidget() {
    return Observer(
      builder: (_) => TextButton(
        onPressed: !controller.loading ? controller.registrar : null,
        child: Text("REGISTRAR-SE"),
        style: ElevatedButton.styleFrom(
          onPrimary: Colors.white,
          padding: EdgeInsets.all(16),
          side: BorderSide(color: Colors.white),
        ),
      ),
    );
  }
}
