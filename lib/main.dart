import 'package:dun_cookie_flutter/common/tool/color_theme.dart';
import 'package:dun_cookie_flutter/page/Error/main.dart';
import 'package:dun_cookie_flutter/page/update_dialog/main.dart';
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
      theme: DunTheme.themeList[0],
      onUnknownRoute: (settings) =>
          MaterialPageRoute(builder: (context) => DunError(error: "404")),
      initialRoute: "/",
    );
  }
}
