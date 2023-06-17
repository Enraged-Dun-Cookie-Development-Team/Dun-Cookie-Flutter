import 'package:dun_cookie_flutter/common/tool/color_theme.dart';
import 'package:flutter/cupertino.dart';

class ContainerWithLabel extends StatelessWidget {
  final double containerWidth;
  final String text;
  final Color textColor;
  final Color containerBgColor;
  final Color labelColor;
  const ContainerWithLabel(
      {Key? key,
      required this.containerWidth,
      required this.text,
      this.textColor = white,
      this.containerBgColor = gray_1,
      this.labelColor = gray_3})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          height: 42,
          width: containerWidth + 7,
          child: Stack(
            children: [
              Container(
                margin: const EdgeInsets.only(right: 7),
                width: containerWidth,
                color: containerBgColor,
                child: Center(
                  child: Text(
                    text,
                    style: TextStyle(
                      fontSize: 16,
                      color: textColor,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  margin: const EdgeInsets.only(bottom: 6),
                  width: 17,
                  height: 10,
                  color: labelColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
