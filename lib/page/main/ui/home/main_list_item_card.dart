import 'package:dun_cookie_flutter/common/tool/color_theme.dart';
import 'package:dun_cookie_flutter/common/tool/time_unit.dart';
import 'package:dun_cookie_flutter/model/cookie_main_list_model.dart';
import 'package:dun_cookie_flutter/model/setting_data.dart';
import 'package:dun_cookie_flutter/widget/dashed_line_widget.dart';
import 'package:flutter/material.dart';

import '../../../../common/tool/open_app_or_browser.dart';
import '../../../../version_2.0/widget/cookie/cookie_title.dart';
import 'cookie_share.dart';
import 'expandable_text.dart';
import 'images_widget.dart';

class MainListItemCard extends StatelessWidget {
  final Cookies data;
  final SettingData? settingData;

  const MainListItemCard(
      {required this.data, required this.settingData, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _goSource(
          context, data.source!.type!, data.item!.id!, data.item!.url!),
      child: Container(
        margin: const EdgeInsets.only(top: 10),
        color: Colors.white,
        child: Column(
          children: [_buildTop(context), _buildContent(context)],
        ),
      ),
    );
  }

  Widget _buildTop(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// 左上灰色label
        Container(
          margin: const EdgeInsets.only(bottom: 1, right: 10),
          width: 15,
          height: 60,
          color: gray_1,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildTitle(),
                  Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: _buildShareIcon(context),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: DashedLine(
                        axis: Axis.horizontal,
                        count: 100,
                        dashedColor: gray_1,
                      ),
                    ),
                  ),

                  /// 右上黄色label
                  Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: Container(
                      width: 13,
                      height: 19,
                      color: yellow,
                    ),
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }

  Widget _buildTitle() {
    String timestamp = "";
    if (data.timestamp?.platformPrecision == null ||
        data.timestamp!.platformPrecision! == "none") {
      timestamp = TimeUnit.timestampFormatYMDHNS(data.timestamp!.fetcher!);
    } else if (data.timestamp!.platformPrecision! == "second" ||
        data.timestamp!.platformPrecision! == "ms") {
      timestamp = TimeUnit.timestampFormatYMDHNS(data.timestamp!.platform!);
    } else {
      timestamp = TimeUnit.timestampFormatYMD(data.timestamp!.platform!);
    }
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: CookieTitle(
        cookieTitle: data.datasource ?? '',
        titleColor: yellow,
        time: timestamp,
        timeColor: gray_2,
        icon: data.icon,
      ),
    );
  }

  Widget _buildShareIcon(BuildContext context) {
    return IconButton(
      iconSize: 18,
      icon: const Icon(Icons.share),
      color: Colors.black,
      onPressed: () {
        Navigator.pushNamed(context, CookieWidgetToImage.routeName,
            arguments: data);
      },
    );
  }

  Widget _buildContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ExpandableText(
            data.defaultCookie?.text ?? '',
            style: const TextStyle(
              color: gray_2,
              fontSize: 12,
            ),
          ),
          data.item?.retweeted != null
              ? Container(
                  padding: const EdgeInsets.all(5),
                  color: gray_4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ExpandableText(
                        "转发自：" +
                            (data.item?.retweeted?.authorName ?? "") +
                            "\n" +
                            (data.item?.retweeted?.text ?? ''),
                        style: const TextStyle(
                          color: gray_2,
                          fontSize: 12,
                        ),
                      ),
                      ImageWidget(
                        data: data.item?.retweeted?.images,
                        sourceType: data.source?.type,
                        settingData: settingData,
                      )
                    ],
                  ))
              : Container(),
          ImageWidget(
            data: data.defaultCookie?.images,
            sourceType: data.source?.type,
            settingData: settingData,
          ),
          const SizedBox(
            height: 10,
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
