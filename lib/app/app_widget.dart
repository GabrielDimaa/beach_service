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
      initialRoute: Modular.initialRoute,
      theme: ThemeData(
        primaryColor: PaletaCores.primary,
        primaryColorLight: PaletaCores.light,
        primaryColorDark: PaletaCores.dark,
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: PaletaCores.dark,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0.4,
          centerTitle: true,
          textTheme: TextTheme(headline6: TextStyle(color: PaletaCores.primaryLight, fontSize: 20, fontWeight: FontWeight.w500, fontFamily: 'NotoSansJP')),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        scaffoldBackgroundColor: Colors.white,
        textTheme: TextTheme(
          headline1: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.w500, fontFamily: 'NotoSansJP'),
          headline2: TextStyle(color: Colors.white, fontSize: 42, fontWeight: FontWeight.w500, fontFamily: 'NotoSansJP'),
          headline3: TextStyle(color: Colors.white, fontSize: 50, fontWeight: FontWeight.w500, fontFamily: 'NotoSansJP'),
          headline4: TextStyle(color: PaletaCores.primaryLight, fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'NotoSansJP'),
          bodyText1: TextStyle(color: Colors.grey[700], fontSize: 15, fontWeight: FontWeight.bold, fontFamily: 'NotoSansJP'),
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
        dialogTheme: DialogTheme(
          backgroundColor: Colors.white,
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          titleTextStyle: TextStyle(fontSize: 20, color: Colors.black, fontFamily: 'NotoSansJP'),
          contentTextStyle: TextStyle(fontSize: 16, color: Colors.black, fontFamily: 'NotoSansJP'),
        ),
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
            onPrimary: PaletaCores.primaryLight,
            padding: EdgeInsets.all(10),
            textStyle: TextStyle(fontSize: 14, fontFamily: 'NotoSansJP'),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            primary: PaletaCores.primaryLight,
            padding: EdgeInsets.all(10),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
            textStyle: TextStyle(fontSize: 14, fontFamily: 'NotoSansJP'),
          ),
        ),
        cardTheme: CardTheme(
          elevation: 4,
          color: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
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

  static Color dark = Color(0xFF3F66A2);
  static Color light = Color(0xFF8AABFB);
  static Color error = Color(0xFFC1666B);

  static List<Color> gradiente = [primaryLight, primary];
}
