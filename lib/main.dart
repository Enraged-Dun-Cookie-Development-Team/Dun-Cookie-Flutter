import 'package:dun_cookie_flutter/common/tool/color_theme.dart';
import 'package:dun_cookie_flutter/page/Error/main.dart';
import 'package:dun_cookie_flutter/model/ceobecanteen_info.dart';
import 'package:dun_cookie_flutter/model/source_data.dart';
import 'package:dun_cookie_flutter/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'provider/common_provider.dart';

void main() {
  runApp(const DunMain());
  // 现在只有安卓
  // 沉浸式状态栏
  SystemUiOverlayStyle systemUiOverlayStyle = const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent);
  SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
}

class DunMain extends StatelessWidget {
  const DunMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CommonProvider>(create: (_) => CommonProvider()),
        ChangeNotifierProvider<CeobecanteenInfo>(
            create: (_) => CeobecanteenInfo()),
        ChangeNotifierProvider<SourceData>(create: (_) => SourceData()),
      ],
      child: MaterialApp(
        title: "小刻食堂",
        routes: DunRouter.routes,
        theme: DunTheme.themeList[0],
        onUnknownRoute: (settings) =>
            MaterialPageRoute(builder: (context) => DunError(error: "404")),
        initialRoute: "/",
      ),
    );
  }
}
