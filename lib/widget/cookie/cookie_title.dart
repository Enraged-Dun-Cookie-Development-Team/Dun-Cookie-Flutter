import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../common/time_unit.dart';
import '../../model/cookie/cookie_main_list.dart';
import '../image/dun_image.dart';

class CookieTitle extends StatelessWidget {
  final Cookie cookie;
  final TextStyle? titleStyle;
  final TextStyle? timeStyle;
  final double avatarRadius;

  const CookieTitle({
    super.key,
    required this.cookie,
    this.titleStyle,
    this.timeStyle,
    this.avatarRadius = 0.0,
  });

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

    String sourceName = cookie.datasource;
    if (sourceName.endsWith('-安卓') && Platform.isOhos) {
      sourceName = cookie.datasource.replaceFirst('-安卓', '-安卓(鸿蒙4)');
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
              sourceName,
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
          ? DunImage.network(
              icon,
              width: 40,
              height: 40,
              fit: BoxFit.cover,
            )
          : Image.asset(
              "assets/image/load/load.png",
              width: size.width,
              height: size.height,
              fit: BoxFit.cover,
            ),
    );
  }
}
