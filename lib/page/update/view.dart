import 'dart:io';

import 'package:dun_cookie_flutter/common/dun_jump.dart';
import 'package:dun_cookie_flutter/common/dun_toast.dart';
import 'package:dun_cookie_flutter/manager/update_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/data_status.dart';
import '../../common/dun_color.dart';
import '../../common/file_util.dart';
import '../../widget/progress.dart';

class UpdatePage extends StatelessWidget {
  const UpdatePage({super.key});

  UpdateManager get manmager => UpdateManager.getInstance();

  void onTapBack() {
    if (manmager.isForce) {
      DunToast.showInfo("这波啊，是强制更新");
    } else {
      Get.back();
    }
  }

  void jumpExternalWeb(String url) {
    DunJump.openExternalWeb(url);
  }

  void jumpAppStore() {
    DunJump.openAppUrlScheme(
      "https://apps.apple.com/cn/app/id1629917304",
    );
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context)
          .copyWith(textScaler: const TextScaler.linear(1.0)),
      child: PopScope(
        canPop: !manmager.isForce,
        onPopInvoked: (didPop) {
          if (didPop) return;
          if (manmager.isForce) {
            DunToast.showInfo("这波啊，是强制更新");
          }
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: onTapBack,
            ),
            iconTheme: const IconThemeData(
              color: DunColors.dunColor,
            ),
            centerTitle: true,
            titleTextStyle:
                const TextStyle(color: DunColors.dunColor, fontSize: 20),
            title: const Text("检查更新"),
            elevation: 0,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Image(
                        image: AssetImage("assets/logo/logo_no_line.png"),
                        width: 50,
                      ),
                      const SizedBox(width: 13),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "当前版本",
                            style: TextStyle(fontSize: 15),
                          ),
                          Text(
                            manmager.nowVersion,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                  _content("新版本", manmager.dunAppInfo.version),
                  _content("更新模式", manmager.isForce ? "强制" : "非强制",
                      color: manmager.isForce ? Colors.red : Colors.black),
                  _content("更新内容", manmager.dunAppInfo.description),
                  const SizedBox(height: 30),
                  _buildDownloadView(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _content(title, content, {Color? color}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 25),
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        Text(content, style: TextStyle(color: color)),
      ],
    );
  }

  Widget _buildDownloadView() {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Platform.isIOS
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildPrimaryButton(text: '应用商店', onPressed: jumpAppStore),
              ],
            )
          : Obx(
              () => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (![DataStatus.loading, DataStatus.success]
                      .contains(manmager.downloadStatus.value)) ...[
                    _buildPrimaryButton(
                        text: '下载', onPressed: manmager.startDownload),
                    ...List.generate(
                      manmager.manualUrlModels.length,
                      (index) {
                        final urlModel = manmager.manualUrlModels[index];
                        String text = urlModel.name;
                        if (text.isEmpty) text = '手动下载方式 ${index + 1}';
                        return _buildPrimaryButton(
                          text: text,
                          onPressed: () => jumpExternalWeb(urlModel.url),
                        );
                      },
                    )
                  ],
                  if (manmager.downloadStatus.value == DataStatus.loading) ...[
                    _buildDownloadProgress(),
                    _buildTextButton(
                        text: '取消', onPressed: manmager.cancelDownload),
                  ],
                  if (manmager.downloadStatus.value == DataStatus.success) ...[
                    _buildPrimaryButton(
                        text: '安装', onPressed: manmager.installApp),
                    _buildTextButton(
                        text: '重新下载', onPressed: manmager.startDownload),
                  ],
                ],
              ),
            ),
    );
  }

  Widget _buildDownloadProgress() {
    return ProgressBuilder(
      controller: manmager.downloadProgressController,
      builder: (context, count, total, percent) {
        final countStr = FileUtil.getReadableFileSize(count, fractionDigits: 1),
            totalStr = FileUtil.getReadableFileSize(total, fractionDigits: 1);
        return Column(
          children: [
            LinearProgressIndicator(
              value: percent,
              backgroundColor: DunColors.dunColor.withOpacity(0.2),
              color: DunColors.dunColor,
              minHeight: 8,
              borderRadius: BorderRadius.circular(99),
            ),
            Padding(
              padding: const EdgeInsets.all(4),
              child: Row(
                children: [
                  Expanded(
                      child:
                          Text(manmager.curDownloadUrlModel.value?.name ?? '')),
                  const SizedBox(width: 4),
                  Text('$countStr / $totalStr')
                ],
              ),
            )
          ],
        );
      },
    );
  }

  Widget _buildPrimaryButton({
    required String text,
    required void Function()? onPressed,
  }) {
    return ElevatedButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all(const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)))),
        backgroundColor: MaterialStateProperty.all(DunColors.dunColor),
      ),
      onPressed: onPressed,
      child: Text(text, style: const TextStyle(color: Colors.white)),
    );
  }

  Widget _buildTextButton({
    required String text,
    required void Function()? onPressed,
  }) {
    return TextButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all(const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)))),
      ),
      onPressed: onPressed,
      child: Text(text, style: const TextStyle(color: DunColors.dunColor)),
    );
  }
}
