import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:beach_service/app/shared/extensions/string_extension.dart';

class AlertDialogWidget extends StatefulWidget {
  final String title;
  final String content;
  final List<Widget> actions;

  AlertDialogWidget({this.title, this.content, this.actions});

  static Future show(BuildContext context, {String title, String content, List<Widget> actions}) async {
    await showDialog(
      context: context,
      builder: (_) => AlertDialogWidget(
        title: title,
        content: content,
        actions: actions,
      ),
    );
  }

  @override
  _AlertDialogWidgetState createState() => _AlertDialogWidgetState();
}

class _AlertDialogWidgetState extends State<AlertDialogWidget> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Visibility(
        visible: widget.title.notIsNullOrEmpty(),
        child: Text(widget.title ?? ""),
      ),
      content: Text(widget.content.replaceAll("Exception: ", "") ?? ""),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      actions: widget.actions ?? [TextButton(onPressed: Modular.to.pop, child: Text("OK"))],
    );
  }
}
