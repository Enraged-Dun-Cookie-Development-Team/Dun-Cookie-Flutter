import 'package:dun_cookie_flutter/common/tool/color_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SetUpButtonWidget extends StatelessWidget {
  const SetUpButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 72.w,
      height: 42.h,
      child: Row(
        children: [
          Container(
            width: 14.w,
            color: gray_1,
          ),
          Expanded(
            child: Container(
              color: Colors.white,
              child: Container(
                padding: REdgeInsets.all(5),
                child: Image.asset(
                  "assets/icon/settings.png"
                ),
              )
              
            ),
          ),
          Container(
            width: 14.w,
            color: gray_1,
          ),
        ],
      ),
    );
  }
}
