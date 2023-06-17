import 'package:dun_cookie_flutter/common/tool/color_theme.dart';
import 'package:flutter/material.dart';

/// 横向虚线
class DashedLineWidget extends StatelessWidget {
  final double? width;
  final double itemLength;
  final double itemPadding;
  const DashedLineWidget({Key? key, this.width, this.itemLength = 1.5, this.itemPadding = 1.5})
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
