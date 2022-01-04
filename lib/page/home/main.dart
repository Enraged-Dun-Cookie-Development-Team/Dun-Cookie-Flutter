import 'package:dun_cookie_flutter/page/home/kaze_body.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Image(
              image: AssetImage("assets/logo/logo.png"),
              width: 30,
            ),
            Container(
                margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: const Text("小刻食堂 alpha"))
          ],
        ),
      ),
      body: KazeBody(),
    );
  }
}
