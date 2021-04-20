import 'package:beach_service/app/app_widget.dart';
import 'package:flutter/material.dart';

class IconTextWidget extends StatelessWidget {
  final String text;
  final IconData icon;

  const IconTextWidget({Key key, this.text, this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: PaletaCores.primaryLight, size: 32),
        SizedBox(width: 12),
        Text(text, style: TextStyle(color: Colors.blue)),
      ],
    );
  }
}
