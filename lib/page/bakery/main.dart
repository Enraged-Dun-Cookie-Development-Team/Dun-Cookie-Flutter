import 'package:flutter/material.dart';

class Bakery extends StatelessWidget {
  const Bakery({Key? key}) : super(key: key);
  static String routeName = "/bakery";

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Text("Bakery"),
    );
  }
}
