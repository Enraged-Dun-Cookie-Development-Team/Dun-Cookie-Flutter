import 'package:flutter/material.dart';

class DunError extends StatelessWidget {
  DunError({Key? key, error}) : super(key: key);

  late String error;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text("错误，请联系我们处理！"),
          Text(
            error,
            style: TextStyle(fontSize: 36, color: Colors.red),
          )
        ],
      ),
    );
  }
}
