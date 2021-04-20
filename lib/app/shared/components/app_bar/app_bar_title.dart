import 'package:flutter/material.dart';

class AppBarTitleWidget extends StatelessWidget {
  final String title;

  const AppBarTitleWidget({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Padding(
      padding: EdgeInsets.only(top: 58, bottom: 52),
      child: Text(title, style: theme.headline1),
    );
  }
}
