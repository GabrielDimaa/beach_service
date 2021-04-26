import 'package:beach_service/app/modules/login/login_controller.dart';
import 'package:beach_service/app/shared/components/form/text_form_field_widget.dart';
import 'package:beach_service/app/shared/components/form/validator.dart';
import 'package:beach_service/app/shared/components/icon_text_widget.dart';
import 'package:beach_service/app/shared/components/scaffold_widget.dart';
import 'package:beach_service/app/shared/defaults/default_sized_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class LoginPage extends StatefulWidget {
  final String title;

  const LoginPage({Key key, this.title = "LoginPage"}) : super(key: key);

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends ModularState<LoginPage, LoginController> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return ScaffoldWidget(
      padding: EdgeInsets.all(0),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _logo(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 36),
              child: Column(
                children: [
                  Text("Bem Vindo", style: theme.textTheme.headline1),
                  DefaultSizedBox(),
                  _login(),
                  DefaultSizedBox(),
                  Text("Não tem conta? Registre-se!"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _logo() {
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

  Widget _login() {
    return Column(
      children: [
        Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormFieldWidget(
                label: "Email",
                //controller: _controllerNome,
                keyboardType: TextInputType.name,
                //onSaved: controller.userStore.setNome,
                validator: InputValidator(EmailValidator()).validate,
              ),
              DefaultSizedBox(),
              TextFormFieldWidget(
                label: "Senha",
                //controller: _controllerEmail,
                keyboardType: TextInputType.emailAddress,
                //onSaved: controller.userStore.setEmail,
                validator: InputValidator(PasswordValidator()).validate,
              ),
            ],
          ),
        ),
        SizedBox(height: 6),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {},
            child: Text("Esqueceu a senha?"),
            style: ElevatedButton.styleFrom(onPrimary: Colors.white),
          ),
        ),
        SizedBox(height: 6),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {},
            child: IconTextWidget(text: "ENTRAR", icon: Icons.login),
          ),
        ),
      ],
    );
  }
}
