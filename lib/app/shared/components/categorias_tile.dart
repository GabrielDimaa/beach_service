import 'package:beach_service/app/app_widget.dart';
import 'package:flutter/material.dart';

class CategoriasTile extends StatelessWidget {
  final String label;
  final EdgeInsets margin;

  const CategoriasTile({Key key, this.label, this.margin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? EdgeInsets.all(0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: PaletaCores.gradiente,
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 6),
      child: Text(label),
    );
  }
}
