import 'package:dun_cookie_flutter/page/main/dun_list.dart';
import 'package:flutter/material.dart';

class MainScaffold extends StatelessWidget {
  const MainScaffold({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar,
      body: MainList(),
    );
  }

  static final PreferredSizeWidget _appBar = AppBar(
    title: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Image(
          image: AssetImage("assets/logo/logo.png"),
          height: 30,
        ),
        SizedBox(
          width: 5,
        ),
        Text("小刻食堂 - 列表"),
      ],
    ),
  );
}
