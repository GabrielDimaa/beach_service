import 'package:beach_service/app/app_widget.dart';
import 'package:flutter/material.dart';

class IconTextWidget extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color color;

  const IconTextWidget({Key key, this.text, this.icon, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color ?? PaletaCores.primaryLight, size: 28),
        SizedBox(width: 12),
        Text(text, style: TextStyle(color: color ?? PaletaCores.primaryLight, fontSize: 16)),
      ],
    );
  }
}
