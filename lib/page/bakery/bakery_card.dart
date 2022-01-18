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
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(
        child: Text("蜜饼工坊，敬请期待"),
      ),
    );
  }
}
