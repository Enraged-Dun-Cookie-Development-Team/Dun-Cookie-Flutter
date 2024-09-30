import 'package:dun_cookie_flutter/common/assets.gen.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../common/time_unit.dart';
import '../../model/cookie/cookie_main_list.dart';

class CookieTitle extends StatelessWidget {
  final Cookie cookie;
  final TextStyle? titleStyle;
  final TextStyle? timeStyle;
  final double avatarRadius;

  const CookieTitle({
    Key? key,
    required this.cookie,
    this.titleStyle,
    this.timeStyle,
    this.avatarRadius = 0.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String timestamp = "";
    if (cookie.timestamp.platformPrecision == "none") {
      timestamp = TimeUnit.timestampFormatYMDHNS(cookie.timestamp.fetcher);
    } else if (cookie.timestamp.platformPrecision == "second" ||
        cookie.timestamp.platformPrecision == "ms") {
      timestamp = TimeUnit.timestampFormatYMDHNS(cookie.timestamp.platform);
    } else {
      timestamp = TimeUnit.timestampFormatYMD(cookie.timestamp.platform);
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 2, right: 8.w),
          child: _buildIcon(cookie.icon, const Size(40, 40)),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              cookie.datasource,
              style: titleStyle,
            ),
            Text(
              timestamp,
              style: timeStyle,
            )
          ],
        )
      ],
    );
  }

  Widget _buildIcon(String? icon, Size size) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(avatarRadius),
      child: icon != null
          ? ExtendedImage.network(
              icon,
              width: 40,
              height: 40,
              fit: BoxFit.cover,
              alignment: Alignment.topLeft,
              handleLoadingProgress: true,
              clearMemoryCacheIfFailed: true,
              clearMemoryCacheWhenDispose: false,
              mode: ExtendedImageMode.gesture,
              cache: true,
            )
          : Assets.image.load.load.image(
              width: size.width,
              height: size.height,
              fit: BoxFit.cover,
              alignment: Alignment.topLeft,
            ),
    );
  }

}
