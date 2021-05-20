import 'package:beach_service/app/app_widget.dart';
import 'package:flutter/material.dart';

class ItemDrawer extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isSelected;

  const ItemDrawer({Key key, this.icon, this.label, this.onTap, this.isSelected = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return ListTile(
      title: Text(
        label,
        style: isSelected ? theme.textTheme.bodyText1.copyWith(color: PaletaCores.primaryLight) : theme.textTheme.bodyText1,
      ),
      leading: Icon(icon, color: isSelected ? PaletaCores.primaryLight : null,),
      onTap: onTap,
    );
  }
}
