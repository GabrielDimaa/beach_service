import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final Widget child;
  final Color background;
  final Color borderColor;
  final EdgeInsets padding;
  final Function onPressed;

  const RoundedButton({Key key, this.child, this.background, this.padding, this.borderColor, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        primary: background ?? Colors.white38,
        padding: padding ?? EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        shape: RoundedRectangleBorder(
          side: BorderSide(color: borderColor ?? Colors.transparent, width: 0.7),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: child ?? Container(),
    );
  }
}
