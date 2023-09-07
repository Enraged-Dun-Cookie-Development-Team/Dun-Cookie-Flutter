import 'dart:async';

import 'package:dun_cookie_flutter/common/tool/color_theme.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class ToSettingDialog extends Dialog {
  int curentTimer = 5;
  String content = "我知道了(5)";
  bool disable = true;
  late Timer _timer;

  StateSetter? aState;

  @override
  Widget build(BuildContext context) {
    _timer = Timer.periodic(const Duration(milliseconds: 1000), (timer) {
      curentTimer--;
      content = "我知道了($curentTimer)";
      if (curentTimer == 0) {
        content = "我知道了    ";
        _timer.cancel();
        disable = false;
      }
      aState!(() {});
    });
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: _buildToSettingDialog(context),
      ),
    );
  }

  _buildToSettingDialog(BuildContext context) {
    return Container(
      width: MediaQuery
          .of(context)
          .size
          .width * 0.8,
      padding: const EdgeInsets.only(top: 8, bottom: 2),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "用户初体验提醒",
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 10,right: 10),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "为了能稳定及时的推送新饼，需要：",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                Text(
                  " 1.锁定应用后台，不被系统杀死",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                Text(
                  " 2.若有省点策略，设置为无限制",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                Text(
                  " 3.检查通知权限有无打开",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                Text(
                  " 4.设置完上诉，关闭小刻食堂后台再打开",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            child: Container(
                padding: const EdgeInsets.only(top: 15),
                child: Column(
                  children: [
                    const Divider(
                      color: Colors.grey,
                      height: 1,
                      thickness: 1,
                    ),
                    SizedBox(
                      height: 45,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextButton(
                            onPressed: () {
                              openAppSettings();
                              Navigator.of(context).pop();
                            },
                            child: const Text(
                              '   前往设置',
                              style: TextStyle(fontSize: 17),
                            ),
                          ),
                          const VerticalDivider(
                            color: Colors.grey,
                            width: 1,
                            thickness: 1,
                          ),
                          StatefulBuilder(
                            builder:
                                (BuildContext context, StateSetter setState) {
                              aState = setState;
                              return TextButton(
                                  onPressed: disable
                                      ? null
                                      : () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(content,
                                      style: TextStyle(
                                        fontSize: 17,
                                        color:
                                        disable ? Colors.grey : Colors.blue,
                                      )));
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
