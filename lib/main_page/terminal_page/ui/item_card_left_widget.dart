import 'package:dun_cookie_flutter/common/tool/color_theme.dart';
import 'package:flutter/cupertino.dart';

class ItemCardLeftWidget extends StatelessWidget {
  final String columnText;
  final String titleText;
  final String centerText;
  final Color labelColor;
  final bool isDays;

  const ItemCardLeftWidget(
      {Key? key,
      required this.columnText,
      required this.titleText,
      required this.centerText,
      this.labelColor = blue,
      this.isDays = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> titleTextList = [];
    for (int i = 0; i < columnText.length; i++) {
      titleTextList.add(Text(columnText[i], style: const TextStyle(color: white, fontSize: 8)));
    }

    return Container(
      width: 131,
      color: white,
      child: Stack(
        children: [
          Container(
            width: 18,
            color: gray_1,
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(9, 9, 0, 0),
            width: 18,
            height: 10,
            color: labelColor,
          ),
          Positioned(
            left: 6,
            top: 24,
            child: Column(children: titleTextList),
          ),
          Positioned(
            left: 32,
            top: 4,
            child: Text(
              titleText,
              style: const TextStyle(
                color: gray_1,
                fontSize: 18,
              ),
            ),
          ),
          Positioned(
            left: 60,
            top: 25,
            child: Text(
              centerText,
              style: const TextStyle(
                color: gray_1,
                fontSize: 36,
              ),
            ),
          ),
          isDays ? const Positioned(
            left: 103,
            top: 65,
            child: Text(
              '天',
              style: TextStyle(
                color: gray_1,
                fontSize: 16,
              ),
            ),
          ) : Container(),
        ],
      ),
    );
  }
}
