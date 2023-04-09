import 'package:dun_cookie_flutter/common/tool/color_theme.dart';
import 'package:flutter/material.dart';

class SetUpButtonWidget extends StatelessWidget {
  const SetUpButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 72,
      height: 42,
      child: Row(
        children: [
          Container(
            width: 14,
            color: gray_1,
          ),
          Expanded(
            child: Container(
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(width: 19, height: 3, color: gray_1),
                  const SizedBox(height: 5),
                  Container(width: 19, height: 3, color: gray_1),
                  const SizedBox(height: 5),
                  Container(width: 19, height: 3, color: gray_1),
                ],
              ),
            ),
          ),
          Container(
            width: 14,
            color: gray_1,
          ),
        ],
      ),
    );
  }
}
