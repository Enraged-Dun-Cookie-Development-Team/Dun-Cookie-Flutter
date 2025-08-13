import 'package:flutter/material.dart';

class DunColors {
  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);
  static const Color gray_1 = Color(0xFF707070);
  static const Color gray_2 = Color(0xFF676767);
  static const Color gray_3 = Color(0xFFE7E7E7);
  static const Color gray_4 = Color(0xFFE9E9E9);
  static const Color graySubtitle = Color(0xFFB8B8B8);
  static const Color yellow = Color(0xFFFDBA4B);
  static const Color blue = Color(0xFF8BDCFF);
  static const Color red = Color(0xFFFD3082);
  static const Color dunColor = Color(0xFFF2AC3C);
  static const Color dunColorLight = Color.fromARGB(255, 97, 186, 234);
  static const Color dunColorGrey = Color(0xFF353535);
  static const Color dunColorComplementary = Color.fromARGB(255, 199, 131, 65);
  static const Color dunColorBlue = Color.fromARGB(255, 35, 173, 229);

  static const Color dunPink = Color(0xFFf25d8e);

  static const Color bakeryColor = Color.fromARGB(255, 245, 130, 32);
  static const Color bakeryColorLight = Color.fromARGB(255, 230, 132, 56);
  static const Color bakeryColorGrey = Color.fromARGB(255, 170, 172, 183);
  static const Color bakeryColorComplementary =
      Color.fromARGB(255, 22, 191, 255);
  static const Color blackBackground = Color(0xFF333333);

  static const Color cardShadow = Color(0x29000000);
}

class DunStyles {
  static const text14C = TextStyle(fontSize: 14, color: DunColors.dunColor);
  static const text16C = TextStyle(fontSize: 16, color: DunColors.dunColor);
  static const text18C = TextStyle(fontSize: 18, color: DunColors.dunColor);
  static const text20C = TextStyle(fontSize: 20, color: DunColors.dunColor);
  static const text26C = TextStyle(fontSize: 26, color: DunColors.dunColor);
  static const text30C = TextStyle(fontSize: 30, color: DunColors.dunColor);
  static const text12 = TextStyle(fontSize: 12);
  static const text12B = TextStyle(fontSize: 12, color: Colors.black45);
  static const text14 = TextStyle(fontSize: 14);
  static const text16 = TextStyle(fontSize: 16);
  static const text18 = TextStyle(fontSize: 18);
  static const text12B45 = TextStyle(fontSize: 12, color: Colors.black45);
  static const cookieContent =
      TextStyle(fontSize: 12, color: Color(0xFF393939));
  static const cookieRetweeted =
      TextStyle(fontSize: 12, color: Color.fromRGBO(57, 57, 57, 0.8));
  static const text14B45 = TextStyle(fontSize: 14, color: Colors.black45);
  static const text16B45 = TextStyle(fontSize: 16, color: Colors.black45);
  static const text12G2 = TextStyle(fontSize: 12, color: DunColors.gray_2);
}

class DunTheme {
  static const BoxShadow cardShadow = BoxShadow(
    offset: Offset(0, 3),
    blurRadius: 2,
    spreadRadius: 1,
    color: DunColors.cardShadow,
  );
}
