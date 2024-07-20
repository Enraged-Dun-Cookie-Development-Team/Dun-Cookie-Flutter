import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../common/dun_color.dart';
import '../../common/dun_toast.dart';
import '../../model/ceobe/version/dun_app.dart';
import '../../route.dart';

class UpdateDialog extends Dialog {
  final String oldVersion; //旧版本
  final DunAppInfoModel newApp; //新版本
  final bool isFocus; //强制更新

  const UpdateDialog(
      {super.key,
      required this.oldVersion,
      required this.newApp,
      required this.isFocus});

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: _buildVersionUpdateDialog(context),
      ),
    );
  }

  Widget _buildVersionUpdateDialog(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      padding: REdgeInsets.only(top: 8, bottom: 2),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: Text(
              "发现新版本",
              style: TextStyle(
                color: DunColors.DunColor,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.85,
              constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.width * 0.5),
              padding: REdgeInsets.only(top: 8, left: 15, right: 5),
              child: Scrollbar(
                thumbVisibility: false,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        isFocus ? "强制更新" : "非强制更新",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: isFocus ? Colors.red : Colors.black,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        "$oldVersion —> ${newApp.version}",
                        style: const TextStyle(
                          fontSize: 13,
                          color: DunColors.gray_1,
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        "更新内容",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        newApp.description,
                        style: const TextStyle(
                          fontSize: 13,
                          color: DunColors.gray_1,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            child: Container(
                padding: REdgeInsets.only(top: 15),
                child: Column(
                  children: [
                    const Divider(
                      color: Colors.grey,
                      thickness: 1.2,
                      height: 2,
                    ),
                    SizedBox(
                      height: 45,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextButton(
                            onPressed: () {
                              _confirmCallBack();
                            },
                            child: const Text(
                              '前往更新',
                              style: TextStyle(
                                  fontSize: 17, color: DunColors.DunColor),
                            ),
                          ),
                          const VerticalDivider(
                            color: Colors.grey,
                            thickness: 0.9,
                            width: 1,
                          ),
                          TextButton(
                              onPressed: () {
                                _cancelCallBack(context);
                              },
                              child: Text(isFocus ? "退出" : "暂不更新",
                                  style: const TextStyle(
                                      fontSize: 17, color: DunColors.gray_1))),
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

  Future<void> _confirmCallBack() async {
    Get.offAndToNamed(DunRouter.update,arguments: newApp);
    DunToast.showSuccess("正在跳转到更新页面");
  }

  void _cancelCallBack(BuildContext context) {
    if (isFocus) {
      exit(0);
    } else {
      Get.back();
    }
  }
}
