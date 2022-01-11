import 'package:dun_cookie_flutter/model/source_data.dart';
import 'package:dun_cookie_flutter/page/main/dun_content.dart';
import 'package:dun_cookie_flutter/page/main/dun_headren.dart';
import 'package:dun_cookie_flutter/page/main/dun_image.dart';
import 'package:flutter/material.dart';

class DunCardItem extends StatefulWidget {
  DunCardItem({Key? key, required this.info,required this.index}) : super(key: key);
  SourceData info;
  int index;// 列表的第几个
  @override
  _DunCardItemState createState() => _DunCardItemState();
}

class _DunCardItemState extends State<DunCardItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  late final Animation<double> _opacityAnimate;
  late final Animation<double> _translateAnimate;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _opacityAnimate = Tween<double>(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _translateAnimate = Tween<double>(begin: 100, end: 0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _controller.forward();

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SourceData info = widget.info;
    return GestureDetector(
      onTap: () => _goSource(info.jumpUrl),
      child: AnimatedBuilder(
          animation: Listenable.merge([_opacityAnimate, _translateAnimate]),
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(0, _translateAnimate.value),
              child: Opacity(
                opacity: _opacityAnimate.value,
                child: Column(
                  children: [
                    DunHead(info),
                    DunContent(info),
                    DunImage(info),
                    Container(
                      width: double.infinity,
                      height: 6,
                      color: Colors.black12,
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }

  // 浏览器打开
  void _goSource(url) {
    Navigator.pushNamed(context, "/webView", arguments: url);
  }
}
