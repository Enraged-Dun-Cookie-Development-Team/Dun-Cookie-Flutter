import 'package:dun_cookie_flutter/common/tool/color_theme.dart';
import 'package:flutter/material.dart';

/// 横向虚线
class DashedLineHorizontalWidget extends StatelessWidget {
  final double? width;
  final double itemLength;
  final double itemPadding;
  const DashedLineHorizontalWidget({Key? key, this.width, this.itemLength = 1.5, this.itemPadding = 1.5})
      : super(key: key);

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, constraints) {
          double dashedLength =
              width ?? (constraints.maxWidth == double.infinity ? 0 : constraints.maxWidth);
          return SizedBox(
            height: 1.5,
            width: dashedLength,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: (dashedLength / (itemLength + itemPadding)).ceil(),
              itemBuilder: (context, index) => Row(
                children: [
                  SizedBox(width: itemPadding),
                  Container(width: itemLength, color: gray_1),
                ],
              ),
            ),
          );
        },
      );
}

/// 竖向虚线
class DashedLineVerticalWidget extends StatelessWidget {
  final double? height;
  final double itemLength;
  final double itemPadding;
  const DashedLineVerticalWidget({Key? key, this.height, this.itemLength = 1.5, this.itemPadding = 1.5})
      : super(key: key);

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) {
      double dashedLength =
          height ?? (constraints.maxHeight == double.infinity ? 0 : constraints.maxHeight);
      return SizedBox(
        height: dashedLength,
        width: 1.5,
        child: Center (
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: (dashedLength / (itemLength + itemPadding)).ceil(),
            itemBuilder: (context, index) => Column(
              children: [
                SizedBox(height: itemPadding),
                Container(height: itemLength, color: gray_1),
              ],
            ),
          ),
        )
      );
    },
  );
}
