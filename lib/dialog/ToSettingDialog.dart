import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class ToSettingDialog extends Dialog {

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: _buildToSettingDialog(context),
      ),
    );
  }

  _buildToSettingDialog(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
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
            "允许锁后台",
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          SizedBox(
            child: Container(
                padding: const EdgeInsets.only(top: 15),
                child: Column(
                  children: [
                    const Divider(
                      color: Colors.grey,
                      height: 2,
                    ),
                    SizedBox(
                      height: 45,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextButton(
                            onPressed: () {
                              openAppSettings();
                            },
                            child: const Text(
                              '前往设置',
                              style: TextStyle(fontSize: 17),
                            ),
                          ),
                          const VerticalDivider(
                            color: Colors.grey,
                            width: 2,
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text(
                                  "我知道了",
                                  style: TextStyle(fontSize: 17)
                              )),
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