import 'package:dun_cookie_flutter/page/main/dun_main.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const DunMain());
}

class DunMain extends StatelessWidget {
  const DunMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home:  MainScaffold()
    );
  }
}
