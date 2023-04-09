import 'package:dun_cookie_flutter/common/tool/color_theme.dart';
import 'package:flutter/cupertino.dart';

class MoreListItemWidget extends StatelessWidget {
  const MoreListItemWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 114,
      decoration: BoxDecoration(
        color: white,
        border: Border.all(
          color: gray_1,
          width: 1,
        ),
      ),
      child: Stack(
        children: [],
      ),
    );
  }
}
