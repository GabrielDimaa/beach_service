import 'package:beach_service/app/app_widget.dart';
import 'package:beach_service/app/shared/defaults/default_padding.dart';
import 'package:flutter/material.dart';

class ListSeparated<T> extends StatelessWidget {
  final List<T> list;
  final EdgeInsets padding;
  final EdgeInsets contentPanding;
  final Function onTap;
  final bool isSelected;

  const ListSeparated({
    Key key,
    this.list,
    this.onTap,
    this.padding,
    this.contentPanding,
    this.isSelected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? DefaultPadding.paddingList,
      child: ListView.separated(
        itemCount: list.length,
        separatorBuilder: (_, __) => Container(
          height: 0.5,
          color: Colors.grey[300],
        ),
        itemBuilder: (_, int index) {
          return ListTile(
            title: Text("${list[index]}", style: isSelected ? TextStyle(color: PaletaCores.primaryLight) : TextStyle(),),
            trailing: isSelected ? Icon(Icons.check, color: PaletaCores.primaryLight,) : null,
            contentPadding: contentPanding ?? EdgeInsets.symmetric(horizontal: 10),
            onTap: onTap,
          );
        },
      ),
    );
  }
}
