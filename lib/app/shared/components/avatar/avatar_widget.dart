import 'package:beach_service/app/app_widget.dart';
import 'package:flutter/material.dart';

class AvatarWidget extends StatelessWidget {
  final double iconSize;
  final double circleSize;
  final Color backgroundColor;
  final Color iconColor;

  const AvatarWidget({
    Key key,
    this.iconSize,
    this.circleSize,
    this.backgroundColor,
    this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: circleSize ?? 68,
      height: circleSize ?? 68,
      child: CircleAvatar(
        backgroundColor: backgroundColor ?? Colors.white,
        child: Icon(Icons.person, size: iconSize ?? 48, color: iconColor ?? PaletaCores.primaryLight),
      ),
    );
  }
}
