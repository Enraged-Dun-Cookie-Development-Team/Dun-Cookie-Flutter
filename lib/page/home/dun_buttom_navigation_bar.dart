//底部栏
import 'package:dun_cookie_flutter/provider/common_event_bus.dart';
import 'package:dun_cookie_flutter/provider/common_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DunBottomNavigationBar extends StatefulWidget {
  DunBottomNavigationBar({
    Key? key,
  }) : super(key: key);

  @override
  _DunBottomNavigationBarState createState() => _DunBottomNavigationBarState();
}

class _DunBottomNavigationBarState extends State<DunBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 6, 0, 6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ButtonItem(
                index: 1,
                content: "assets/logo/logo_mb@noactive.png",
                activeContent: "assets/logo/logo_mb.png",
                label: "蜜饼工坊"),
            ButtonItem(
                index: 2,
                content: "assets/image/tool@noactive.png",
                activeContent: "assets/image/tool.png",
                label: "常用工具"),
          ],
        ),
      ),
    );
  }
}

class ButtonItem extends StatefulWidget {
  ButtonItem(
      {Key? key,
      required this.index,
      required this.content,
      required this.activeContent,
      required this.label})
      : super(key: key);

  int index;
  String content;
  String activeContent;
  String label;

  @override
  _ButtonItemState createState() => _ButtonItemState();
}

class _ButtonItemState extends State<ButtonItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late final Animation<double> _logoSizeAnimate;
  late final Animation<double> _textSizeAnimate;
  late final Animation<Colors> _colorsAnimate;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Consumer<CommonProvider>(
        builder: (ctx, data, child) {
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => _onTap(widget.index, data),
            child: Image.asset(
              data.routerIndex != widget.index
                  ? widget.content
                  : widget.activeContent,
              gaplessPlayback: true,
              height: 30,
            ),
          );
        },
      ),
    );
  }

  _onTap(index, CommonProvider data) {
    if (index != data.routerIndex) {
      Provider.of<CommonProvider>(context, listen: false)
          .setRouterIndex(index);
    }
  }
}
