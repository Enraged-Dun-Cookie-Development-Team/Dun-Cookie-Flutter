import 'package:dun_cookie_flutter/common/tool/color_theme.dart';
import 'package:flutter/material.dart';

class DunTag extends StatelessWidget {
  const DunTag(this.text, {Key? key}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
      decoration: BoxDecoration(
          border: Border.all(color: DunColors.DunColorBlue),
          borderRadius: BorderRadius.circular(50)),
      child: Text(text,style: const TextStyle(fontSize: 14,color: DunColors.DunColorBlue),),
    );
  }
}
