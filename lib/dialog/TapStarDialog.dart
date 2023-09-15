import 'dart:io';

import 'package:dun_cookie_flutter/common/tool/color_theme.dart';
import 'package:flutter/material.dart';
import 'package:in_app_review/in_app_review.dart';

import '../model/ceobecanteen_data.dart';
import '../page/update/main.dart';

class TapStartDialog extends Dialog {

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
      width: MediaQuery.of(context).size.width * 0.8,
      padding: const EdgeInsets.only(top: 8, bottom: 2),
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
              "支持小刻食堂",
              style: TextStyle(
                color: DunColors.DunColor,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.width * 0.5),
              padding: const EdgeInsets.only(top: 8, left: 15, right: 5),
              child: const Scrollbar(
                thumbVisibility: false,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        "你对小刻食堂还满意吗？给个好评吧！",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
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
                padding: const EdgeInsets.only(top: 15),
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
                              _cancelCallBack(context);
                            },
                            child: const Text(
                              '下次一定',
                              style: TextStyle(
                                fontSize: 17,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          const VerticalDivider(
                            color: Colors.grey,
                            thickness: 0.9,
                            width: 1,
                          ),
                          TextButton(
                              onPressed: () {
                                _confirmCallBack(context);
                              },
                              child: const Text("给个好评",
                                  style: TextStyle(fontSize: 17,color: DunColors.DunColor))),
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

  Future<void> _confirmCallBack(BuildContext context) async {
    final InAppReview inAppReview = InAppReview.instance;
    if (await inAppReview.isAvailable()) {
      inAppReview.requestReview();
    }
    Navigator.of(context).pop();
  }

  void _cancelCallBack(BuildContext context) {
    Navigator.of(context).pop();
  }
}
