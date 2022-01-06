import 'package:dun_cookie_flutter/model/source_data.dart';
import 'package:dun_cookie_flutter/model/source_info.dart';
import 'package:flutter/material.dart';

class DunContent extends StatelessWidget {
  DunContent(this.info, {Key? key})
      : super(key: key);

  SourceData info;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      child: Text(info.content.toString()),
      padding: const EdgeInsets.all(10),
    );
  }
}
