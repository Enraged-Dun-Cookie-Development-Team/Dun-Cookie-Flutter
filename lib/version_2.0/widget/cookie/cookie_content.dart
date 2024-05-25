import 'package:flutter/material.dart';

import '../../../common/tool/color_theme.dart';
import '../../model/cookie/cookie_main_list.dart';
import '../expandable_text.dart';

class CookieContent extends StatelessWidget {
  Cookie cookie;
  Color? contentColor;
  bool isShare;
  static TextStyle contentStyle = const TextStyle(
    color: gray_2,
    fontSize: 12,
  );

  CookieContent({Key? key, required this.cookie, this.isShare = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildContent(cookie.defaultCookie?.text ?? ""),
          _buildRetweeted(cookie.item?.retweeted),
          _buildImage(cookie.defaultCookie?.images),
          const SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }

  _buildRetweeted(Retweeted? retweeted) {
    return retweeted != null
        ? Container(
            padding: const EdgeInsets.all(5),
            color: gray_4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildContent("转发自：${retweeted.authorName}\n${retweeted.text}"),
                _buildImage(retweeted.images)
              ],
            ))
        : const SizedBox();
  }

  _buildContent(String content) {
    return isShare
        ? Text(
            content,
            style: contentStyle,
          )
        : ExpandableText(
            content,
            style: contentStyle,
          );
  }

  _buildImage(List<CookieImage>? images) {
    return Container();
  }
}
