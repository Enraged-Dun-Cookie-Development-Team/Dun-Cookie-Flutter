import 'package:dun_cookie_flutter/common/pubilc.dart';
import 'package:flutter/material.dart';

class ToolSourceAndTool extends StatelessWidget {
  ToolSourceAndTool(this.title, {Key? key}) : super(key: key);

  String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(color: DunColors.DunColor, fontSize: 16),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 9,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,
              mainAxisSpacing: 2,
              crossAxisSpacing: 2,
            ),
            itemBuilder: (ctx, index) {
              return Card(
                child: Center(
                  child: Text(index.toString()),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
