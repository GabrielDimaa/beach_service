import 'package:beach_service/app/modules/splach/splach_controller.dart';
import 'package:beach_service/app/shared/components/scaffold/scaffold_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SplachPage extends StatefulWidget {
  @override
  _SplachPageState createState() => _SplachPageState();
}

class _SplachPageState extends ModularState<SplachPage, SplachController> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 3), () => controller.load());
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      isBackButton: false,
      body: Center(
        child: Image.asset('assets/images/logo.png', scale: 1.2)
      ),
    );
  }
}
