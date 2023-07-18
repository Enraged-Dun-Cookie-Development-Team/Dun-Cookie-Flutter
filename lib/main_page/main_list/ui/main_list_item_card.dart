
import 'package:dun_cookie_flutter/common/tool/color_theme.dart';
import 'package:dun_cookie_flutter/common/tool/time_unit.dart';
import 'package:dun_cookie_flutter/main_page/common_ui/dashed_line_widget.dart';
import 'package:dun_cookie_flutter/main_page/main_list/ui/images_widget.dart';
import 'package:dun_cookie_flutter/model/setting_data.dart';
import 'package:dun_cookie_flutter/model/cookie_main_list_model.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

import '../../../common/tool/open_app_or_browser.dart';
import 'cookie_share.dart';

class MainListItemCard extends StatelessWidget {
  final Cookies? data;
  final SettingData? settingData;
  const MainListItemCard({required this.data, required this.settingData, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _goSource(context, data!.source!.type!, data!.item!.id!, data!.item!.url!),
      child: Container(
      margin: const EdgeInsets.only(top: 12),
      color: white,
        child: Stack(
          children: [
            ..._buildBg(),
            _buildIcon(),
            _buildTitle(),
            _buildTime(),
            _buildShareIcon(context),
            _buildContent(context),
          ],
        ),
      )
    );
  }

  List<Widget> _buildBg() {
    return [
      /// 左上灰色label
      Container(
        width: 14,
        height: 60,
        color: gray_1,
      ),

      /// 右上黄色label
      Positioned(
        top: 51,
        right: 18,
        child: Container(
          width: 13,
          height: 19,
          color: yellow,
        ),
      ),

      /// 虚线
      const Positioned(
        left: 26,
        top: 60,
        right: 40,
        child: DashedLineHorizontalWidget(),
      )
    ];
  }

  Widget _buildIcon() {
    return Positioned(
      left: 26,
      top: 11,
      child: data?.icon != null ? ExtendedImage.network(
        data!.icon!,
        handleLoadingProgress: true,
        clearMemoryCacheIfFailed: true,
        clearMemoryCacheWhenDispose: false,
        mode: ExtendedImageMode.gesture,
        cache: true,
        width: 38,
        height: 38,
        fit: BoxFit.cover,
        alignment: Alignment.topLeft,
      ) : Image.asset(
        "assets/image/load/loading.gif",
        width: 38,
        height: 38,
        fit: BoxFit.cover,
        alignment: Alignment.topLeft,
      ),
    );
  }

  Widget _buildTitle() {
    return Positioned(
      left: 70,
      top: 11,
      child: Text(
        data?.datasource ?? '',
        style: const TextStyle(
          fontSize: 15,
          color: yellow,
        ),
      ),
    );
  }

  Widget _buildTime() {
    String timestamp = "";
    if (data?.timestamp?.platformPrecision == null || data!.timestamp!.platformPrecision! == "none") {
      timestamp = "";
    } else if (data!.timestamp!.platformPrecision! == "second" || data!.timestamp!.platformPrecision! == "ms") {
      timestamp = TimeUnit.timestampFormatYMDHNS(data!.timestamp!.platform!);
    } else {
      timestamp = TimeUnit.timestampFormatYMD(data!.timestamp!.platform!);
    }
    return Positioned(
      left: 70,
      top: 32,
      child: Text(
        timestamp,
        style: const TextStyle(
          fontSize: 13,
          color: gray_2,
        ),
      ),
    );
  }

  Widget _buildShareIcon(BuildContext context) {
    return Positioned(
        right: 10,
        top: 6,
        child:IconButton(
          iconSize: 18,
          icon: const Icon(Icons.share),
          onPressed: () {
            Navigator.pushNamed(context, CookieWidgetToImage.routeName,
                arguments: data);
          },
        ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(26, 73, 26, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              data?.defaultCookie?.text ?? '',
              style: const TextStyle(
                color: gray_2,
                fontSize: 12,
              ),
            ),
            data?.item?.retweeted != null ? Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Colors.black38,
                      width: 1
                  )
              ),
              child: Column(
                children: [
                  Text(
                    "转发自：" + (data?.item?.retweeted?.authorName ?? "") + "\n" + (data?.item?.retweeted?.text ?? ''),
                    style: const TextStyle(
                      color: gray_2,
                      fontSize: 12,
                    ),
                  ),
                  ImageWidget(
                    data: data?.item?.retweeted?.images,
                    sourceType: data?.source?.type,
                    settingData: settingData,
                  )
                ],
              )
            ): Container(),
            ImageWidget(
              data: data?.defaultCookie?.images,
              sourceType: data?.source?.type,
              settingData: settingData,
            ),
          ],
        ),
      );
  }

  // 浏览器打开
  void _goSource(BuildContext context, String type, String id, String url) {
    String appUrl = "";
    if (type == "bilibili:dynamic-by-uid") {
      // bilibili
      appUrl = "bilibili://following/detail/$id";
    } else if (type == "weibo:dynamic-by-uid") {
      // weibo
      appUrl = "sinaweibo://detail?mblogid=$id";
    } else if (type == "netease-cloud-music:albums-by-artist") {
      // 网易云音乐
      appUrl = "orpheus://album/$id";
    }
    // Navigator.pushNamed(context, DunWebView.routeName, arguments: url);
    OpenAppOrBrowser.openUrl(url, context, appUrlScheme: appUrl);
  }
}
