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
      titleTextList.add(
        Text(
          columnText[i],
          style: TextStyle(
            color: DunColors.white,
            fontSize: 8.sp,
          ),
        ),
      );
    }
    return Stack(
      children: [
        Row(
          children: [
            Expanded(
              flex: 18,
              child: ColoredBox(
                color: DunColors.gray_1,
                child: Padding(
                  padding: REdgeInsets.only(top: 22, left: 6, right: 6),
                  child: Column(
                    children: titleTextList,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 113,
              child: ColoredBox(
                color: DunColors.white,
                child: Padding(
                  padding: REdgeInsets.only(top: 5, bottom: 11, left: 14),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              titleText,
                              style: TextStyle(
                                color: DunColors.gray_1,
                                fontSize: 18.sp,
                                height: 1,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              centerText,
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: DunColors.gray_1,
                                fontSize: 36.sp,
                                height: 1,
                              ),
                            ),
                            SizedBox(height: 20.h),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 35.w,
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Text(
                            bottomText ?? '',
                            style: TextStyle(
                              color: DunColors.gray_1,
                              fontSize: 16.sp,
                              height: 1,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        Positioned(
          top: 9.h,
          left: 9.w,
          child: SizedBox(
            width: 18.sp,
            height: 10.sp,
            child: ColoredBox(
              color: labelColor,
            ),
          ),
        )
      ],
    );
  }
}
