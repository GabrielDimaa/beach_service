import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final Widget child;
  final Color onSurface;
  final Color borderColor;
  final EdgeInsets padding;

  const RoundedButton({Key key, this.child, this.onSurface, this.padding, this.borderColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ElevatedButton.styleFrom(
        onSurface: onSurface,
        padding: padding ?? EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        shape: RoundedRectangleBorder(
          side: BorderSide(color: borderColor, width: 0.7),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: child ?? Container(),
    );
  }
}
