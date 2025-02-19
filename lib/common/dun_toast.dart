import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'dun_color.dart';

class DunToast {
  static const double _fontsize = 16.0;

  static showInfo(text) {
    Fluttertoast.showToast(
        msg: text,
        textColor: Colors.white,
        backgroundColor: DunColors.dunColor,
        fontSize: _fontsize);
  }

  static showLongTimeInfo(text, {time = 1}) {
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_LONG,
        textColor: Colors.white,
        backgroundColor: DunColors.dunColor,
        fontSize: _fontsize);
  }

  // https://pub.dev/packages/fluttertoast
  // 安卓11无法上色 官方有方案 后期方法添加
  static showSuccess(text) {
    Fluttertoast.showToast(
        msg: text,
        textColor: Colors.white,
        backgroundColor: DunColors.dunColor,
        fontSize: _fontsize);
  }

  static showError(text) {
    Fluttertoast.showToast(
        msg: text,
        textColor: Colors.white,
        backgroundColor: Colors.red,
        fontSize: _fontsize);
  }

  static showCancel() {
    Fluttertoast.cancel();
  }
}
