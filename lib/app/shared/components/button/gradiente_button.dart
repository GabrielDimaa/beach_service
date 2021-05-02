import 'package:beach_service/app/app_widget.dart';
import 'package:flutter/material.dart';

class GradienteButton extends StatelessWidget {
  final Function onPressed;
  final Widget child;
  final double width;
  final List<Color> colors;

  const GradienteButton({
    Key key,
    this.onPressed,
    this.child,
    this.colors,
    this.width = double.infinity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(padding: EdgeInsets.all(0)),
        child: Container(
          width: width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.centerRight,
                end: Alignment.centerLeft,
                colors: colors ?? PaletaCores.gradiente
            ),
          ),
          padding: EdgeInsets.all(10),
          child: Center(child: child),
        ),
      ),
    );
  }
}