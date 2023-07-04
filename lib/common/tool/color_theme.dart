import 'package:flutter/material.dart';

const Color white = Color(0xFFFFFFFF);
const Color gray_1 = Color(0xFF707070);
const Color gray_2 = Color(0xFF676767);
const Color gray_3 = Color(0xFFE7E7E7);
const Color gray_subtitle = Color(0xFFB8B8B8);
const Color yellow = Color(0xFFFDBA4B);
const Color blue = Color(0xFF8BDCFF);
const Color red = Color(0xFFFD3082);

class DunColors {
  static const Color DunColor = Color(0xFFF2AC3C);
  static const Color DunColorLigth = Color.fromARGB(255, 97, 186, 234);
  static const Color DunColorGrey = Color(0xFF353535);
  static const Color DunColorComplementary = Color.fromARGB(255, 199, 131, 65);
  static const Color DunColorBlue = Color.fromARGB(255, 35, 173, 229);

  static const Color DunPink = Color(0xFFf25d8e);

  static const Color BakeryColor = Color.fromARGB(255, 245, 130, 32);
  static const Color BakeryColorLigth = Color.fromARGB(255, 230, 132, 56);
  static const Color BakeryColorGrey = Color.fromARGB(255, 170, 172, 183);
  static const Color BakeryColorComplementary =
      Color.fromARGB(255, 22, 191, 255);
}

class DunStyles {
  static const text14C = TextStyle(fontSize: 14, color: DunColors.DunColor);
  static const text16C = TextStyle(fontSize: 16, color: DunColors.DunColor);
  static const text18C = TextStyle(fontSize: 18, color: DunColors.DunColor);
  static const text20C = TextStyle(fontSize: 20, color: DunColors.DunColor);
  static const text26C = TextStyle(fontSize: 26, color: DunColors.DunColor);
  static const text30C = TextStyle(fontSize: 30, color: DunColors.DunColor);
  static const text12 = TextStyle(fontSize: 12);
  static const text14 = TextStyle(fontSize: 14);
  static const text16 = TextStyle(fontSize: 16);
  static const text18 = TextStyle(fontSize: 18);
  static const text12B = TextStyle(fontSize: 12, color: Colors.black45);
  static const text14B = TextStyle(fontSize: 14, color: Colors.black45);
  static const text16B = TextStyle(fontSize: 16, color: Colors.black45);
}

class DunTheme {
  static ThemeData getThemeData(Color color, Brightness brightness) {
    ThemeData td = ThemeData(colorSchemeSeed: color, brightness: brightness);
    ThemeData tdlight =
        ThemeData(colorSchemeSeed: color, brightness: Brightness.light);
    Color primaryThemeColor = tdlight.primaryColor;
    Color primaryColor = color;
    ThemeData rst = td.copyWith(
      appBarTheme: AppBarTheme(
        color:
            brightness == Brightness.light ? primaryColor : primaryThemeColor,
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          primary: Colors.white,
          backgroundColor: primaryColor,
        ),
      ),
    );
    return rst;
  }

  // static final ThemeData _mainTheme = ThemeData(
  //   brightness: Brightness.light,
  //   primaryColor: DunColors.DunColor,
  //   elevatedButtonTheme: ElevatedButtonThemeData(
  //     style: ButtonStyle(
  //       overlayColor: MaterialStateProperty.all(DunColors.DunPink), // 波纹颜色
  //       backgroundColor: MaterialStateProperty.resolveWith(
  //         (states) {
  //           if (states.contains(MaterialState.pressed)) {
  //             return DunColors.DunColorLigth; // 点击颜色
  //           }
  //           return DunColors.DunColor;
  //         },
  //       ),
  //     ),
  //   ),
  //   appBarTheme: const AppBarTheme(backgroundColor: DunColors.DunColor),
  //   splashColor: DunColors.DunPink,
  //   colorScheme:
  //       ColorScheme.fromSwatch().copyWith(secondary: DunColors.DunColorLigth),
  // );

  static List<ThemeData> themeList = [
    getThemeData(DunColors.DunColor, Brightness.light)
  ];

  static List<ThemeData> darkThemeList = [
    getThemeData(DunColors.DunColor, Brightness.dark)
  ];
}
