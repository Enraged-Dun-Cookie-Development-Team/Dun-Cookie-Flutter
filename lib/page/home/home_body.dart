import 'package:dun_cookie_flutter/router/router.dart';
import 'package:flutter/material.dart';

class HomeBody extends StatefulWidget {
  HomeBody(this.routerIndex, {Key? key}) : super(key: key);

  int routerIndex;

  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

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
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: DunRouter.pages[widget.routerIndex],
        )
      ],
    );
  }
}
