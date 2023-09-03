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
              child: Container(
                padding: const EdgeInsets.all(5),
                child: Image.asset(
                  "assets/icon/settings.png"
                ),
              )
              
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
