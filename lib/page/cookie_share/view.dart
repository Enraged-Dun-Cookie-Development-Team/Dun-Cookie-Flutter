import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../common/dun_color.dart';
import '../../model/cookie/cookie_main_list.dart';
import '../../widget/cookie/cookie_content.dart';
import '../../widget/cookie/cookie_title.dart';
import 'logic.dart';

class CookieSharePage extends StatelessWidget {
  CookieSharePage({super.key});

  final logic = Get.put(CookieShareLogic());
  final state = Get.find<CookieShareLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DunColors.blackBackground,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: DunColors.gray_3),
        title: const Text(
          "小刻分享",
          style: TextStyle(color: DunColors.gray_3),
        ),
        actions: [
          IconButton(
              onPressed: () => logic.onTapSave(),
              icon: const Icon(Icons.save_alt)),
          IconButton(
              onPressed: () => logic.onTapShare(),
              icon: const Icon(Icons.share))
        ],
        elevation: 0,
        backgroundColor: DunColors.blackBackground,
      ),
      body: SingleChildScrollView(
        child: RepaintBoundary(
          key: state.boundaryKey,
          child: GetBuilder<CookieShareLogic>(
            id: state.rootGID,
            builder: (logic) {
              return _buildBody(state.cookie);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildBody(Cookie cookie) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: REdgeInsets.symmetric(horizontal: 150),
          child: Image.asset(
            "assets/logo/logo_no_line_share.png",
            fit: BoxFit.fill,
          ),
        ),
        _buildCard(cookie),
        _buildBottom(),
      ],
    );
  }

  Widget _buildCard(Cookie cookie) {
    return Card(
      margin: REdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          _buildTitle(cookie),
          _buildContent(cookie),
        ],
      ),
    );
  }

  Widget _buildTitle(Cookie cookie) {
    return Padding(
      padding: REdgeInsets.only(right: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: REdgeInsets.all(8),
                  child: RichText(
                    text: const TextSpan(
                        text: "小刻食堂",
                        style: DunStyles.text20C,
                        children: [
                          TextSpan(
                            text: " 移动版",
                            style: DunStyles.text14C,
                          ),
                        ]),
                  ),
                ),
                Container(
                  height: 3,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [DunColors.dunColor, Colors.white],
                    ),
                  ),
                ),
                Padding(
                    padding: REdgeInsets.all(8),
                    child: CookieTitle(
                      cookie: cookie,
                      titleStyle: DunStyles.text16,
                      timeStyle: DunStyles.text14B45,
                      avatarRadius: 8,
                    )),
              ],
            ),
          ),
          Expanded(flex: 2, child: _buildQr(cookie)),
        ],
      ),
    );
  }

  Widget _buildQr(Cookie cookie) {
    return cookie.item.url != ''
        ? QrImageView(
            data: cookie.item.url,
            version: QrVersions.auto,
            gapless: false,
            eyeStyle: const QrEyeStyle(
                eyeShape: QrEyeShape.square, color: DunColors.dunColor),
            dataModuleStyle: const QrDataModuleStyle(
                dataModuleShape: QrDataModuleShape.square,
                color: DunColors.dunColor),
          )
        : Container();
  }

  Widget _buildContent(Cookie cookie) {
    return Padding(
      padding: REdgeInsets.symmetric(horizontal: 8),
      child: Obx(() => CookieContent(
            cookie: state.type.value == CookieContentType.image
                ? cookie.copyWithImageList(
                    images: state.selectedImage,
                    retweetedImages: state.selectedRetweetedImage)
                : cookie,
            type: state.type.value,
            onSelectImage: logic.onSelectImage,
          )),
    );
  }

  Widget _buildBottom() {
    return Padding(
      padding: REdgeInsets.only(top: 5, bottom: 30),
      child: Center(
        child: Text(
          "-- 搜索小刻食堂下载软件 --",
          style: DunStyles.text14C.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
