import 'package:animate_do/animate_do.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:dun_cookie_flutter/common/tool/time_unit.dart';
import 'package:dun_cookie_flutter/model/ceobecanteen_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class ToolAnnouncement extends StatefulWidget {
  ToolAnnouncement(this.listData, {Key? key}) : super(key: key);

  List<AnnouncementList> listData;

  @override
  State<ToolAnnouncement> createState() => _ToolAnnouncementState();
}

class _ToolAnnouncementState extends State<ToolAnnouncement> {
  @override
  void initState() {
    var a = widget.listData
        .where((x) => TimeUnit.isTimeRange(null, x.starTime, x.overTime)).toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      margin: const EdgeInsets.all(6),
      child: Swiper(
        itemBuilder: (c, i) {
          return Card(
            child: Center(
              // child: Text("意见建议，请在右上角设置进入反馈查看反馈方法"),
              child: Html(data: widget.listData[i].html),
            ),
          );
        },
        // autoplay: true,
        itemCount: widget.listData.length,
        pagination: const SwiperPagination(),
      ),
    );
  }
}
