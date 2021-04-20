import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Beach Service',
      debugShowCheckedModeBanner: false,
      initialRoute: Modular.initialRoute,
      theme: ThemeData(
        primaryColor: PaletaCores.primary,
        primaryColorLight: PaletaCores.light,
        primaryColorDark: PaletaCores.dark,
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: PaletaCores.dark,
        ),
        textTheme: TextTheme(
          headline1: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.w500, fontFamily: 'NotoSansJP'),
          headline2: TextStyle(color: Colors.white, fontSize: 42, fontWeight: FontWeight.w500, fontFamily: 'NotoSansJP'),
          headline3: TextStyle(color: Colors.white, fontSize: 50, fontWeight: FontWeight.w500, fontFamily: 'NotoSansJP'),
        ),
        iconTheme: IconThemeData(
          color: Colors.white,
          size: 24,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            padding: EdgeInsets.all(14),
            textStyle: TextStyle(fontSize: 14, fontFamily: 'NotoSansJP'),
          ),
        ),
      ),
    ).modular();
  }
}

abstract class PaletaCores {
  static Color primary = Color(0xFF5782F8);
  static Color primaryLight = Color(0xFF5FBAFE);

  static Color dark = Color(0XFF170E97);
  static Color light = Color(0XFF8AABFB);

  static List<Color> gradiente = [primaryLight, primary];
}