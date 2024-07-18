import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../common/dun_color.dart';
import '../../model/cookie/cookie_main_list.dart';
import 'expended_text.dart';
import 'image_widget.dart';

enum CookieContentType {
  normal,
  shared,
  image,
}

class CookieContent extends StatelessWidget {
  final Cookie cookie;
  final CookieContentType type;
  final Function(List<String> imageURLList, int currentIndex)? onTapImage;
  final Function(CookieImage cookieImage, bool value, bool isRetweeted)?
      onSelectImage;

  bool get showAllContent => type != CookieContentType.normal;

  bool get showCheck =>
      type == CookieContentType.shared && onSelectImage != null;

  double get avatarBorderRadius => type == CookieContentType.normal ? 0 : 8;

  const CookieContent({
    Key? key,
    required this.cookie,
    this.type = CookieContentType.normal,
    this.onTapImage,
    this.onSelectImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildContent(cookie.defaultCookie.text, DunStyles.cookieContent),
        _buildRetweeted(cookie.item.retweeted),
        _buildImage(cookie.defaultCookie.images),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }

  _buildRetweeted(Retweeted? retweeted) {
    return retweeted != null
        ? Container(
        padding: REdgeInsets.all(5),
            decoration: BoxDecoration(
                color: DunColors.gray_4,
                borderRadius: BorderRadius.circular(avatarBorderRadius)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildContent("转发自：${retweeted.authorName}\n${retweeted.text}",
                    DunStyles.cookieRetweeted),
                _buildImage(retweeted.images, isRetweeted: true)
              ],
            ))
        : const SizedBox();
  }

  _buildContent(String content, TextStyle style) {
    return showAllContent
        ? Text(
            content,
            style: style,
          )
        : ExpendText(
            text: content,
            maxLines: 17,
            textStyle: style,
          );
  }

  _buildImage(List<CookieImage> images, {bool isRetweeted = false}) {
    return ImageWidget(
      cookieImageList: images,
      sourceType: cookie.source.type,
      onTap: onTapImage,
      onSelect: (CookieImage cookieImage, bool value) {
        if (onSelectImage != null) {
          onSelectImage!(cookieImage, value, isRetweeted);
        }
      },
      showCheck: showCheck,
    );
  }
}
