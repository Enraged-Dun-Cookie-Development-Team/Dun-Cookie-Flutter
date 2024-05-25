import 'package:dun_cookie_flutter/common/tool/color_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrtsTitleWidget extends StatelessWidget {
  const PrtsTitleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42.h,
      child: Stack(children: [
        Container(
          margin: REdgeInsets.only(right: 7),
          padding: REdgeInsets.fromLTRB(16, 0, 24, 0),
          color: gray_1,
          height: double.infinity.h,
          child: Row(
            children: const [
              Text(
                "P R T S",
                style: TextStyle(color: Colors.white),
              ),
              Expanded(child: SizedBox()),
              Text(
                "欢迎回来，博士！",
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Container(
            margin: REdgeInsets.only(bottom: 6),
            width: 17.w,
            height: 10.h,
            color: yellow,
          ),
        ),
      ]),
    );
  }
}
