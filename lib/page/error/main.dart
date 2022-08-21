import 'package:dun_cookie_flutter/common/tool/color_theme.dart';
import 'package:flutter/material.dart';

class DunError extends StatelessWidget {
  DunError({Key? key, error}) : super(key: key);

  late String error;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Text("错误，请联系我们处理！"),
          Text(
            error,
            style: DunStyles.text30C.copyWith(color: Colors.red),
          )
        ],
      ),
    );
  }
}
