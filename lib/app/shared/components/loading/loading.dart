import 'package:beach_service/app/app_widget.dart';
import 'package:beach_service/app/shared/defaults/default_sized_box.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  final String description;

  const LoadingWidget({this.description});

  static show(BuildContext context, {String description}) async {
    await showDialog(
      context: context,
      builder: (_) => Dialog(
        child: LoadingWidget(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        elevation: 12,
        color: Colors.white,
        margin: EdgeInsets.symmetric(horizontal: 50),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 60, width: 60, child: CircularProgressIndicator(backgroundColor: PaletaCores.primaryLight)),
              DefaultSizedBox(),
              Text(
                description ?? "Aguarde...",
                style: TextStyle(fontSize: 14, color: Colors.black, fontFamily: 'NotoSansJP'),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
