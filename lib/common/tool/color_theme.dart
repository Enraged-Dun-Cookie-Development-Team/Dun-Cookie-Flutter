import 'package:flutter/material.dart';

class DunColors {
  static const Color DunColor = Color.fromARGB(255, 35, 173, 229);
  static const Color DunColorLigth = Color.fromARGB(255, 97, 186, 234);
  static const Color DunColorGrey = Color.fromARGB(255, 161, 152, 147);
  static const Color DunColorComplementary = Color.fromARGB(255, 199, 131, 65);

  static const Color DunPink = Color(0xFFf25d8e);

  static const Color BakeryColor = Color.fromARGB(255, 245, 130, 32);
  static const Color BakeryColorLigth = Color.fromARGB(255, 230, 132, 56);
  static const Color BakeryColorGrey = Color.fromARGB(255, 170, 172, 183);
  static const Color BakeryColorComplementary =
      Color.fromARGB(255, 22, 191, 255);
}

class DunTheme {
  static final ThemeData _mainTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: DunColors.DunColor,
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
        highlightElevation: 25,
        focusColor: DunColors.DunColor,
        splashColor: DunColors.DunPink,
        extendedIconLabelSpacing: 50),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.all(DunColors.DunPink), // 波纹颜色
        backgroundColor: MaterialStateProperty.resolveWith(
          (states) {
            if (states.contains(MaterialState.pressed)) {
              return DunColors.DunColorLigth; // 点击颜色
            }
            return DunColors.DunColor;
          },
        ),
      ),
    ),
    appBarTheme: const AppBarTheme(backgroundColor: DunColors.DunColor),
    splashColor: Colors.red,
    colorScheme:
        ColorScheme.fromSwatch().copyWith(secondary: DunColors.DunColorLigth),
    textTheme: const TextTheme(
      headline1: TextStyle(fontSize: 14, color: DunColors.DunColor),
      headline2: TextStyle(fontSize: 16, color: DunColors.DunColor),
      headline3: TextStyle(fontSize: 18, color: DunColors.DunColor),
      headline4: TextStyle(fontSize: 20, color: DunColors.DunColor),
      headline5: TextStyle(fontSize: 26, color: DunColors.DunColor),
      headline6: TextStyle(fontSize: 30, color: DunColors.DunColor),
      bodyText1: TextStyle(fontSize: 14),
      bodyText2: TextStyle(fontSize: 14),
      subtitle1: TextStyle(fontSize: 16),
      subtitle2: TextStyle(fontSize: 14, color: Colors.black45),
    ),
  );

  static final ThemeData _bakeryTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: DunColors.BakeryColor,
    appBarTheme: const AppBarTheme(backgroundColor: DunColors.BakeryColor),
    splashColor: Colors.blue,
    colorScheme: ColorScheme.fromSwatch()
        .copyWith(secondary: DunColors.BakeryColorLigth),
    textTheme: const TextTheme(
      headline1: TextStyle(fontSize: 16, color: DunColors.BakeryColor),
      headline2: TextStyle(fontSize: 18, color: DunColors.BakeryColor),
      headline3: TextStyle(fontSize: 20, color: DunColors.BakeryColor),
      headline4: TextStyle(fontSize: 26, color: DunColors.BakeryColor),
      headline5: TextStyle(fontSize: 30, color: DunColors.BakeryColor),
      headline6: TextStyle(fontSize: 36, color: DunColors.BakeryColor),
      bodyText1: TextStyle(fontSize: 14),
      bodyText2: TextStyle(fontSize: 14),
      subtitle1: TextStyle(fontSize: 16),
      subtitle2: TextStyle(fontSize: 14, color: Colors.black45),
    ),
  );

  static List<ThemeData> themeList = [_mainTheme, _bakeryTheme];
}
