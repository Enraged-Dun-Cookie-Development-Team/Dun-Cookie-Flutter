import 'package:dun_cookie_flutter/page/Error/main.dart';
import 'package:dun_cookie_flutter/router/router.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const DunMain());
}

class DunMain extends StatelessWidget {
  const DunMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: DunRouter.routes,
      onUnknownRoute: (settings) =>
          MaterialPageRoute(builder: (context) => DunError(error: "404")),
      initialRoute: "/",
    );
  }
}

