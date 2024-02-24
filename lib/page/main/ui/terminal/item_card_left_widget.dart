import 'package:dun_cookie_flutter/common/tool/color_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ItemCardLeftWidget extends StatelessWidget {
  final String columnText;
  final String titleText;
  final String centerText;
  final String? bottomText;
  final Color labelColor;

  const ItemCardLeftWidget(
      {Key? key,
      required this.columnText,
      required this.titleText,
      required this.centerText,
      this.bottomText,
      this.labelColor = blue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> titleTextList = [];
    for (int i = 0; i < columnText.length; i++) {
      titleTextList.add(Text(columnText[i], style: const TextStyle(color: white, fontSize: 8)));
    }

    return Container(
      width: 131.w,
      color: white,
      child: Stack(
        children: [
          Container(
            width: 18.w,
            color: gray_1,
          ),
          Container(
            margin: REdgeInsets.fromLTRB(9, 9, 0, 0),
            width: 18.w,
            height: 10.h,
            color: labelColor,
          ),
          Positioned(
            left: 6.w,
            top: 24.h,
            child: Column(children: titleTextList),
          ),
          Positioned(
            left: 32.w,
            top: 4.h,
            child: Text(
              titleText,
              style: const TextStyle(
                color: gray_1,
                fontSize: 18,
              ),
            ),
          ),
          Positioned(
            left: 60.w,
            top: 29.h,
            child: Text(
              centerText,
              style: const TextStyle(
                color: gray_1,
                fontSize: 36,
              ),
            ),
          ),
          bottomText != null ?
              Container(
                alignment: Alignment.bottomRight,
                padding: REdgeInsets.fromLTRB(0, 0, 10, 8),
                child: Text(
                  bottomText!,
                  style: const TextStyle(
                    color: gray_1,
                    fontSize: 16,
                  ),
                ),
              )
           : Container(),
        ],
      ),
    );
  }
}
