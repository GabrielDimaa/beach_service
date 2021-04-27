import 'package:beach_service/app/app_widget.dart';
import 'package:flutter/material.dart';

class ScaffoldWidget extends StatefulWidget {
  final AppBar appBar;
  final FloatingActionButton floatingActionButton;
  final FloatingActionButtonLocation floatingActionButtonLocation;
  final Drawer drawer;
  final Widget body;
  final EdgeInsets padding;

  const ScaffoldWidget({
    Key key,
    this.appBar,
    this.body,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.drawer,
    this.padding,
  }) : super(key: key);

  @override
  _ScaffoldWidgetState createState() => _ScaffoldWidgetState();
}

class _ScaffoldWidgetState extends State<ScaffoldWidget> {
  final defaultPadding = EdgeInsets.symmetric(vertical: 30, horizontal: 36);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.appBar,
      resizeToAvoidBottomInset: false,
      floatingActionButton: widget.floatingActionButton,
      floatingActionButtonLocation: widget.floatingActionButtonLocation,
      drawer: widget.drawer,
      extendBody: true,
      body: FractionallySizedBox(
        widthFactor: 1,
        heightFactor: 1,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: PaletaCores.gradiente,
            ),
          ),
          child: Stack(
            children: [
              Positioned(left: 5, top: 40, child: BackButton()),
              Padding(
                padding: widget.padding ?? defaultPadding,
                child: widget.body ?? Container(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
