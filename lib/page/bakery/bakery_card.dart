import 'package:dun_cookie_flutter/common/tool/open_app_or_browser.dart';
import 'package:flutter/material.dart';

class BakeryCard extends StatefulWidget {
  const BakeryCard({Key? key}) : super(key: key);

  @override
  State<BakeryCard> createState() => _BakeryCardState();
}

class _BakeryCardState extends State<BakeryCard> {
  @override
  void initState() {
    super.initState();
    // Future.delayed(Duration(seconds: 1), (){
    //   Navigator.of(context).pop();
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              "assets/logo/logo_mb.png",
              width: 130,
              excludeFromSemantics: true,
              gaplessPlayback: true,
            ),
            const SizedBox(
              height: 6,
            ),
            Text(
              "蜜饼工坊，大厦基地建设中，敬请期待",
              style: Theme.of(context).textTheme.headline1,
            ),
            const SizedBox(
              height: 6,
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith((states) {
                  return const Color(0xFFF58220);
                }),
              ),
              onPressed: () {
                OpenAppOrBrowser.openUrl(
                    "https://m.bilibili.com/space/8412516", context,
                    appUrlScheme: "bilibili://space/8412516");
              },
              child: const Text("但是你可以点击这里快捷进入B站空间"),
            )
          ],
        ),
      ),
    );
  }
}
