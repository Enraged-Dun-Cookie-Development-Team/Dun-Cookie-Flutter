import 'package:dun_cookie_flutter/common/tool/color_theme.dart';
import 'package:flutter/material.dart';

class PrtsTitleWidget extends StatelessWidget {
  const PrtsTitleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42,
      child: Stack(children: [
        Container(
          margin: const EdgeInsets.only(right: 7),
          padding: const EdgeInsets.fromLTRB(16, 0, 24, 0),
          color: gray_1,
          height: double.infinity,
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
            margin: const EdgeInsets.only(bottom: 6),
            width: 17,
            height: 10,
            color: gray_2,
          ),
        ),
      ]),
    );
  }
}
