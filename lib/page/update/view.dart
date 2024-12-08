import 'dart:io';

import 'package:dun_cookie_flutter/common/data_status.dart';
import 'package:dun_cookie_flutter/common/file_util.dart';
import 'package:dun_cookie_flutter/widget/progress.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../common/dun_color.dart';
import 'logic.dart';

class UpdatePage extends StatelessWidget {
  UpdatePage({super.key});

  final logic = Get.put(UpdateLogic());
  final state = Get.find<UpdateLogic>().state;

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
        data: MediaQuery.of(context)
            .copyWith(textScaler: const TextScaler.linear(1.0)),
        child: GetBuilder<UpdateLogic>(
          id: state.rootGID,
          builder: (UpdateLogic controller) {
            return WillPopScope(
              onWillPop: logic.onWillBack,
              child: Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                  backgroundColor: Colors.white,
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back_ios),
                    onPressed: logic.onTapBack,
                  ),
                  iconTheme: const IconThemeData(
                    color: DunColors.DunColor,
                  ),
                  centerTitle: true,
                  titleTextStyle:
                      const TextStyle(color: DunColors.DunColor, fontSize: 20),
                  title: const Text("检查更新"),
                  elevation: 0,
                ),
                body: SingleChildScrollView(
                  child: Padding(
                    padding: REdgeInsets.only(left: 15, right: 15),
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
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                                Text(
                                  state.nowVersion,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                        _content("新版本", state.newVersion),
                        _content("更新模式", state.isForce ? "强制" : "非强制",
                            color: state.isForce ? Colors.red : Colors.black),
                        _content("更新内容", state.description),
                        const SizedBox(
                          height: 30,
                        ),
                        _buildDownloadView(),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ));
  }

  _content(title, content, {Color? color}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 25,
        ),
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(
          content,
          style: TextStyle(color: color),
        ),
      ],
    );
  }

  _buildDownloadView() {
    return Container(
      padding: REdgeInsets.only(left: 20, right: 20),
      child: GetBuilder<UpdateLogic>(
        id: state.downloadGID,
        builder: (_) => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (Platform.isIOS)
              _buildPrimaryButton(text: '应用商店', onPressed: logic.jumpAppStore),
            if (Platform.isAndroid && state.downloadStatus == null)
              _buildPrimaryButton(text: '下载', onPressed: logic.onTapDownload),
            if (DataStatus.loading == state.downloadStatus)
              _buildDownloadProgress(),
            if (state.downloadStatus == DataStatus.success) ...[
              _buildPrimaryButton(text: '安装', onPressed: logic.installApp),
              _buildTextButton(text: '重新下载', onPressed: logic.onTapDownload),
            ],
            if (state.downloadStatus == DataStatus.error)
              ...List.generate(
                state.manualUrlModels.length,
                (index) {
                  final urlModel = state.manualUrlModels[index];
                  String text = urlModel.name;
                  if (text.isEmpty) text = '手动下载方式 ${index + 1}';
                  return _buildPrimaryButton(
                    text: text,
                    onPressed: () => logic.jumpWebPage(urlModel),
                  );
                },
              )
          ],
        ),
      ),
    );
  }

  ProgressBuilder _buildDownloadProgress() {
    return ProgressBuilder(
      controller: state.downloadProgressController,
      builder: (context, count, total, percent) {
        final countStr = FileUtil.getReadableFileSize(count, fractionDigits: 1),
            totalStr = FileUtil.getReadableFileSize(total, fractionDigits: 1);
        return Column(
          children: [
            LinearProgressIndicator(
              value: percent,
              backgroundColor: DunColors.DunColor.withOpacity(0.2),
              color: DunColors.DunColor,
              minHeight: 8,
              borderRadius: BorderRadius.circular(99),
            ),
            Padding(
              padding: const EdgeInsets.all(4),
              child: Row(
                children: [
                  Expanded(child: Text(state.curDownloadUrlModel?.name ?? '')),
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

  ElevatedButton _buildPrimaryButton({
    required String text,
    required void Function()? onPressed,
  }) {
    return ElevatedButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all(const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)))),
        backgroundColor: MaterialStateProperty.all(DunColors.DunColor),
      ),
      onPressed: onPressed,
      child: Text(text, style: const TextStyle(color: Colors.white)),
    );
  }

  TextButton _buildTextButton({
    required String text,
    required void Function()? onPressed,
  }) {
    return TextButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all(const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)))),
      ),
      onPressed: onPressed,
      child: Text(text, style: const TextStyle(color: DunColors.DunColor)),
    );
  }
}
