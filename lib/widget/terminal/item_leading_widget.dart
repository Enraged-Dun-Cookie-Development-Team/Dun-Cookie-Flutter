
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../common/dun_color.dart';

class ItemLeadingWidget extends StatelessWidget {
  final String columnText;
  final String titleText;
  final String centerText;
  final String? bottomText;
  final Color labelColor;

  const ItemLeadingWidget(
      {super.key,
      required this.columnText,
      required this.titleText,
      required this.centerText,
      this.bottomText,
      this.labelColor = DunColors.blue});

  @override
  Widget build(BuildContext context) {
    List<Widget> titleTextList = [];
    for (int i = 0; i < columnText.length; i++) {
      titleTextList.add(Text(columnText[i],
          style: const TextStyle(
            color: DunColors.white,
            fontSize: 8,
          )));
    }
    return Stack(
      children: [
        Row(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                color: DunColors.gray_1,
                padding: REdgeInsets.only(top: 22),
                child: Column(
                  children: titleTextList,
                ),
              ),
            ),
            Expanded(
              flex: 12,
              child: Container(
                color: DunColors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: REdgeInsets.only(left: 14, top: 4),
                      child: Text(
                        titleText,
                        style: const TextStyle(
                          color: DunColors.gray_1,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          centerText,
                          style: const TextStyle(
                            color: DunColors.gray_1,
                            fontSize: 36,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20,)
                  ],
                ),
              ),
            ),
          ],
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: REdgeInsets.only(right: 10, bottom: 8),
            child: Text(
              bottomText ?? '',
              style: const TextStyle(
                color: DunColors.gray_1,
                fontSize: 16,
              ),
            ),
          ),
        ),
        Positioned(
            top: 9,
            left: 9,
            child: Container(
              color: labelColor,
              width: 18,
              height: 10,
            ))
      ],
    );
  }
}
