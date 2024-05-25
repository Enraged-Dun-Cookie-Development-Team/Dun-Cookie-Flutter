import 'package:dun_cookie_flutter/version_2.0/widget/cookie/cookie_content.dart';
import 'package:flutter/material.dart';

import '../../../common/tool/color_theme.dart';
import '../../../common/tool/time_unit.dart';
import '../../../widget/dashed_line_widget.dart';
import '../../model/cookie/cookie_main_list.dart';
import '../cookie/cookie_title.dart';

class CookieCard extends StatelessWidget {
  final Cookie data;
  final Function(BuildContext context, String type, String id, String url)
      onTapCard;
  final Function(BuildContext context, Cookie data) onTapShare;

  const CookieCard(
      {Key? key,
      required this.data,
      required this.onTapCard,
      required this.onTapShare})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {},
      //onTapCard(context, data.source!.type, data.item!.id, data.item!.url),
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
        data.timestamp!.platformPrecision == "none") {
      timestamp = TimeUnit.timestampFormatYMDHNS(data.timestamp!.fetcher);
    } else if (data.timestamp!.platformPrecision == "second" ||
        data.timestamp!.platformPrecision == "ms") {
      timestamp = TimeUnit.timestampFormatYMDHNS(data.timestamp!.platform);
    } else {
      timestamp = TimeUnit.timestampFormatYMD(data.timestamp!.platform);
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
        //跳转至分享页面
      },
    );
  }

  Widget _buildContent(BuildContext context) {
    return CookieContent(cookie: data);
  }
}
