import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../common/dun_color.dart';

class ContainerWithLabel extends StatelessWidget {
  final double containerWidth;
  final String text;
  final Color textColor;
  final Color containerBgColor;
  final Color labelColor;

  const ContainerWithLabel(
      {super.key,
      required this.containerWidth,
      required this.text,
      this.textColor = DunColors.white,
      this.containerBgColor = DunColors.gray_1,
      this.labelColor = DunColors.gray_3});

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
                margin: REdgeInsets.only(right: 7),
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
                  margin: REdgeInsets.only(bottom: 6),
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
