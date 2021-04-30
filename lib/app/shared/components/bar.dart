import 'package:beach_service/app/app_widget.dart';
import 'package:flutter/material.dart';

class Bar extends StatelessWidget {
  final Widget child;

  const Bar({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 80,
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerRight,
          end: Alignment.centerLeft,
          colors: PaletaCores.gradiente,
        )
      ),
      child: child ?? Container(),
    );
  }
}
