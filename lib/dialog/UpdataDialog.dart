import 'package:dun_cookie_flutter/common/tool/color_theme.dart';
import 'package:flutter/material.dart';

import '../model/ceobecanteen_data.dart';
import '../page/update/main.dart';
import '../request/info_request.dart';

class UpdataDialog extends Dialog {
  final String? oldVersion; //旧版本
  final String? version; //新版本
  final String? description; //更新内容

  UpdataDialog({this.oldVersion,this.version,this.description});

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
                padding: const EdgeInsets.only(top:8, left: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                    "$oldVersion --> $version",
                      style: const TextStyle(
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "更新内容",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      description ?? "",
                      style: const TextStyle(
                        fontSize: 12,
                        color: gray_1,
                      ),
                    ),
                  ],
                )),
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
                              _confirmCallBack(context);
                              Navigator.of(context).pop();
                            },
                            child: const Text(
                              '升级',
                              style: TextStyle(fontSize: 17),
                            ),
                          ),
                          const VerticalDivider(
                            color: Colors.grey,
                            width: 1,
                          ),
                          TextButton(
                              onPressed: () {
                                _cancelCallBack(context);
                                Navigator.of(context).pop();
                              },
                              child: const Text('暂不升级',
                                  style: TextStyle(fontSize: 17))),
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
    DunApp? app = await InfoRequest.getAppVersionInfo();
    Navigator.pushNamed(context, DunUpdate.routerName, arguments: app);
  }

  void _cancelCallBack(BuildContext context) {

  }
}
