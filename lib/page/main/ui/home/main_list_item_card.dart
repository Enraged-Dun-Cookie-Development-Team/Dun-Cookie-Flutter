import 'package:dun_cookie_flutter/common/tool/color_theme.dart';
import 'package:dun_cookie_flutter/common/tool/time_unit.dart';
import 'package:dun_cookie_flutter/page/main/ui/common/dashed_line_widget.dart';

import 'package:dun_cookie_flutter/model/cookie_main_list_model.dart';
import 'package:dun_cookie_flutter/model/setting_data.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common/tool/open_app_or_browser.dart';
import 'cookie_share.dart';
import 'expandable_text.dart';
import 'images_widget.dart';


class MainListItemCard extends StatelessWidget {
  final Cookies? data;
  final SettingData? settingData;
  const MainListItemCard(
      {required this.data, required this.settingData, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => _goSource(
            context, data!.source!.type!, data!.item!.id!, data!.item!.url!),
        child: Container(
          margin: REdgeInsets.only(top: 12),
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
        ));
  }

  List<Widget> _buildBg() {
    return [
      /// 左上灰色label
      Container(
        width: 14.w,
        height: 60.h,
        color: gray_1,
      ),

      /// 右上黄色label
      Positioned(
        top: 51.h,
        right: 18.w,
        child: Container(
          width: 13.w,
          height: 19.h,
          color: yellow,
        ),
      ),

      /// 虚线
      Positioned(
        left: 26.w,
        top: 60.h,
        right: 40.w,
        child: DashedLineHorizontalWidget(),
      )
    ];
  }

  Widget _buildIcon() {
    return Positioned(
      left: 26.w,
      top: 11.h,
      child: data?.icon != null
          ? ExtendedImage.network(
              data!.icon!,
              handleLoadingProgress: true,
              clearMemoryCacheIfFailed: true,
              clearMemoryCacheWhenDispose: false,
              mode: ExtendedImageMode.gesture,
              cache: true,
              width: 38.w,
              height: 38.h,
              fit: BoxFit.cover,
              alignment: Alignment.topLeft,
            )
          : Image.asset(
              "assets/image/load/loading.gif",
              width: 38.w,
              height: 38.h,
              fit: BoxFit.cover,
              alignment: Alignment.topLeft,
            ),
    );
  }

  Widget _buildTitle() {
    return Positioned(
      left: 70.w,
      top: 11.h,
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
    if (data?.timestamp?.platformPrecision == null ||
        data!.timestamp!.platformPrecision! == "none") {
      timestamp = TimeUnit.timestampFormatYMDHNS(data!.timestamp!.fetcher!);
    } else if (data!.timestamp!.platformPrecision! == "second" ||
        data!.timestamp!.platformPrecision! == "ms") {
      timestamp = TimeUnit.timestampFormatYMDHNS(data!.timestamp!.platform!);
    } else {
      timestamp = TimeUnit.timestampFormatYMD(data!.timestamp!.platform!);
    }
    return Positioned(
      left: 70.w,
      top: 32.h,
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
      right: 10.w,
      top: 6.h,
      child: IconButton(
        iconSize: 18.r,
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
      padding: REdgeInsets.fromLTRB(26, 73, 26, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ExpandableText(
            data?.defaultCookie?.text ?? '',
            style: const TextStyle(
              color: gray_2,
              fontSize: 12,
            ),
          ),
          data?.item?.retweeted != null
              ? Container(
                  padding: REdgeInsets.all(5),
                  color: gray_4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ExpandableText(
                        "转发自：" +
                            (data?.item?.retweeted?.authorName ?? "") +
                            "\n" +
                            (data?.item?.retweeted?.text ?? ''),
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
                  ))
              : Container(),
          ImageWidget(
            data: data?.defaultCookie?.images,
            sourceType: data?.source?.type,
            settingData: settingData,
          ),
          SizedBox(
            height: 10.h,
          )
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
