import 'package:dun_cookie_flutter/common/tool/color_theme.dart';
import 'package:dun_cookie_flutter/model/cookie_main_list_model.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

import '../../../../common/tool/time_unit.dart';
import 'cookie_share.dart';

class CookieHead extends StatelessWidget {
  CookieHead(this.info, {Key? key, this.isShowQR = false})
      : super(key: key);

  Cookies info;
  final bool isShowQR;

  @override
  Widget build(BuildContext context) {
    var timestamp = "";
    if (info.timestamp?.platformPrecision == null || info.timestamp!.platformPrecision! == "none") {
      timestamp = "";
    } else if (info.timestamp!.platformPrecision! == "second" || info.timestamp!.platformPrecision! == "ms") {
      timestamp = TimeUnit.timestampFormatYMDHNS(info.timestamp!.platform!);
    } else {
      timestamp = TimeUnit.timestampFormatYMD(info.timestamp!.platform!);
    }
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: ExtendedImage.network(
                  info.icon!,
                  width: 40,
                  height: 40,
                  fit: BoxFit.cover,
                  alignment: Alignment.topLeft,
                  handleLoadingProgress: true,
                  clearMemoryCacheIfFailed: true,
                  clearMemoryCacheWhenDispose: false,
                  mode: ExtendedImageMode.gesture,
                  cache: true,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    info.datasource ?? "",
                    style: DunStyles.text16,
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Text(
                    timestamp,
                    style: DunStyles.text14B,
                  ),
                ],
              )
            ],
          ),
          Row(
            children: [
              isShowQR
                  ? Container()
                  : IconButton(
                      iconSize: 18,
                      icon: const Icon(Icons.share),
                      onPressed: () {
                        Navigator.pushNamed(context, CookieWidgetToImage.routeName,
                            arguments: info);
                      },
                    ),
            ],
          )
        ],
      ),
    );
  }
}
