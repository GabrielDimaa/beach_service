import 'package:beach_service/app/app_widget.dart';
import 'package:flutter/material.dart';

class ScaffoldWidget extends StatefulWidget {
  final AppBar appBar;
  final FloatingActionButton floatingActionButton;
  final FloatingActionButtonLocation floatingActionButtonLocation;
  final Drawer drawer;
  final Widget body;

  const ScaffoldWidget({
    Key key,
    this.appBar,
    this.body,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.drawer,
  }) : super(key: key);

  @override
  _ScaffoldWidgetState createState() => _ScaffoldWidgetState();
}

class _ScaffoldWidgetState extends State<ScaffoldWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.appBar,
      floatingActionButton: widget.floatingActionButton,
      floatingActionButtonLocation: widget.floatingActionButtonLocation,
      drawer: widget.drawer,
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 30, horizontal: 36),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: PaletaCores.gradiente,
          ),
        ),
        child: widget.body ?? Container(),
      ),
    );
  }
}
