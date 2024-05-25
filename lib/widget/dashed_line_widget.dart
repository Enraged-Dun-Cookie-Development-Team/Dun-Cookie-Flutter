import 'package:dun_cookie_flutter/common/tool/color_theme.dart';
import 'package:flutter/material.dart';

/// 横向虚线
class DashedLineHorizontalWidget extends StatelessWidget {
  final double? width;
  final double itemLength;
  final double itemPadding;

  const DashedLineHorizontalWidget(
      {Key? key, this.width, this.itemLength = 1.5, this.itemPadding = 1.5})
      : super(key: key);

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, constraints) {
          double dashedLength = width ??
              (constraints.maxWidth == double.infinity
                  ? 0
                  : constraints.maxWidth);
          return SizedBox(
            width: dashedLength,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: (dashedLength / (itemLength + itemPadding)).ceil(),
              itemBuilder: (context, index) => Row(
                children: [
                  SizedBox(
                    width: itemPadding,
                    height: 1.5,
                  ),
                  Container(
                    width: itemLength,
                    color: gray_1,
                    height: 1.5,
                  ),
                ],
              ),
              padding: EdgeInsets.zero,
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

  const DashedLineVerticalWidget(
      {Key? key, this.height, this.itemLength = 1.5, this.itemPadding = 1.5})
      : super(key: key);

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, constraints) {
          double dashedLength = height ??
              (constraints.maxHeight == double.infinity
                  ? 0
                  : constraints.maxHeight);
          return SizedBox(
            height: dashedLength,
            width: 1.5,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: (dashedLength / (itemLength + itemPadding)).ceil(),
              itemBuilder: (context, index) => Column(
                children: [
                  SizedBox(height: itemPadding),
                  Container(height: itemLength, color: gray_1),
                ],
              ),
              padding: EdgeInsets.zero,
            ),
          );
        },
      );
}

class DashedLine extends StatelessWidget {
  final Axis axis; // 水平方向 & 垂直方向
  final double dashedWidth; // 虚线宽度
  final double dashedHeight; // 虚线高度
  final int count; // 虚线总个数
  final Color dashedColor; // 虚线颜色
  final double? dashedTotalLengthWith; // 虚线水平垂直总长度

  const DashedLine({
    Key? key,
    required this.axis,
    this.dashedWidth = 1.5,
    this.dashedHeight = 1.5,
    this.count = 10,
    this.dashedColor = const Color(0xffff0000),
    this.dashedTotalLengthWith,
  }) : super(key: key);

  Widget showDashedLineWidgets() {
    return Flex(
      direction: axis,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(count, (index) {
        return SizedBox(
          width: dashedWidth,
          height: dashedHeight,
          child: DecoratedBox(
            decoration: BoxDecoration(color: dashedColor),
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return axis == Axis.horizontal
          ? SizedBox(
              width: dashedTotalLengthWith ?? constraints.maxWidth,
              child: showDashedLineWidgets())
          : SizedBox(
              height: dashedTotalLengthWith ?? constraints.maxWidth,
              child: showDashedLineWidgets());
    });
  }
}
