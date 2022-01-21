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
  );

  static final ThemeData _bakeryTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: DunColors.BakeryColor,
    appBarTheme: const AppBarTheme(backgroundColor: DunColors.BakeryColor),
    splashColor: Colors.blue,
    colorScheme: ColorScheme.fromSwatch()
        .copyWith(secondary: DunColors.BakeryColorLigth),
  );

  static List<ThemeData> themeList = [_mainTheme, _bakeryTheme];
}
