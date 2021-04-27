import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Beach Service',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
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
          bodyText1: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500, fontFamily: 'NotoSansJP'),
          bodyText2: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500, fontFamily: 'NotoSansJP'),
        ),
        iconTheme: IconThemeData(
          color: Colors.white,
          size: 24,
        ),
        colorScheme: ColorScheme.light(
          primary: PaletaCores.primary,
          onPrimary: Colors.white,
          onSurface: Colors.black,
        ),
        dialogBackgroundColor: Colors.white,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            padding: EdgeInsets.all(10),
            textStyle: TextStyle(fontSize: 14, fontFamily: 'NotoSansJP'),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: ElevatedButton.styleFrom(
            onPrimary: PaletaCores.primary,
            padding: EdgeInsets.all(10),
            textStyle: TextStyle(fontSize: 14, fontFamily: 'NotoSansJP'),
          ),
        ),
      ),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [const Locale('pt', 'BR')],
    ).modular();
  }
}

abstract class PaletaCores {
  static Color primary = Color(0xFF5782F8);
  static Color primaryLight = Color(0xFF5FBAFE);

  static Color dark = Color(0xFF170E97);
  static Color light = Color(0xFF8AABFB);
  static Color error = Color(0xFFC1666B);

  static List<Color> gradiente = [primaryLight, primary];
}
