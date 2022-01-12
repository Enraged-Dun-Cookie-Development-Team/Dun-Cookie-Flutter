import 'package:card_swiper/card_swiper.dart';
import 'package:dun_cookie_flutter/cache/setting_cache.dart';
import 'package:dun_cookie_flutter/model/ceobecanteen_info.dart';
import 'package:dun_cookie_flutter/service/info_request.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';

class DunTool extends StatefulWidget {
  const DunTool({Key? key}) : super(key: key);
  static String routeName = "/setting";

  @override
  State<DunTool> createState() => _DunToolState();
}

class _DunToolState extends State<DunTool> {
  bool? checkedBoxValue = false;
  CeobecanteenInfo _info = CeobecanteenInfo();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    InfoRequest.getCeobecanteenInfo().then((value) {
      setState(() {
        _info = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
            child: Swiper(
          itemBuilder: (c, i) {
            return Card(
              child: Html(data: _info.list![i].html, customRenders: {
                _classReplace(): CustomRender.widget(widget: (ctx, build) {
                  return Text(
                    "???",
                    style: TextStyle(color: Colors.red),
                  );
                })
              }),
            );
          },
          itemCount: _info.list?.length ?? 0,
          pagination: SwiperPagination(),
          control: SwiperControl(),
        ))
      ],
    );
  }

  CustomRenderMatcher _classReplace() => (context) {
        return context.tree.element?.className == "online-blue";
      };
}
