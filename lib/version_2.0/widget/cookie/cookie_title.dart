import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class CookieTitle extends StatelessWidget {
  final String cookieTitle;
  final Color? titleColor;

  final String time;
  final Color? timeColor;

  final String? icon;

  const CookieTitle(
      {Key? key,
      required this.cookieTitle,
      this.titleColor,
      required this.time,
      this.timeColor,
      this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 4, right: 8),
          child: _buildIcon(icon, const Size(40, 40)),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              cookieTitle,
              style: TextStyle(
                fontSize: 15,
                color: titleColor,
              ),
            ),
            Text(
              time,
              style: TextStyle(
                fontSize: 14,
                color: timeColor,
              ),
            )
          ],
        )
      ],
    );
  }

  Widget _buildIcon(String? icon, Size size) {
    return icon != null
        ? ExtendedImage.network(
            icon,
            handleLoadingProgress: true,
            clearMemoryCacheIfFailed: true,
            clearMemoryCacheWhenDispose: false,
            mode: ExtendedImageMode.gesture,
            cache: true,
            width: size.width,
            height: size.height,
            fit: BoxFit.cover,
            alignment: Alignment.topLeft,
          )
        : Image.asset(
            "assets/image/load/loading.gif",
            width: size.width,
            height: size.height,
            fit: BoxFit.cover,
            alignment: Alignment.topLeft,
          );
  }
}
