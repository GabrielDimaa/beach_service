import 'package:beach_service/app/app_widget.dart';
import 'package:flutter/material.dart';

class Bar extends StatelessWidget {
  final Widget child;
  final double height;
  final EdgeInsets margin;

  const Bar({Key key, this.child, this.height = 80, this.margin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height,
      margin: margin ?? EdgeInsets.only(top: 10),
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
