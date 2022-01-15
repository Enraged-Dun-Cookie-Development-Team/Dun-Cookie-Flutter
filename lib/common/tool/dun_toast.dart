import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DunToast {
  static double fontsize = 16.0;

  static showInfo(text) {
    Fluttertoast.showToast(msg: text, fontSize: fontsize);
  }

  // https://pub.dev/packages/fluttertoast
  // 安卓11无法上色 官方有方案 后期方法添加
  static showSuccess(text) {
    Fluttertoast.showToast(
        msg: text,
        textColor: Colors.white,
        backgroundColor: Colors.green,
        fontSize: fontsize);
  }

  static showError(text) {
    Fluttertoast.showToast(
        msg: text,
        textColor: Colors.white,
        backgroundColor: Colors.red,
        fontSize: fontsize);
  }
}
