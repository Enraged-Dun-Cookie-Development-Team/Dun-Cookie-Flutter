
import 'package:flutter/cupertino.dart';

import 'item_leading_widget.dart';

class ItemCard extends StatelessWidget {
  final ItemLeadingWidget leading;
  final Widget content;
  final double height;

  const ItemCard(
      {Key? key,
      required this.leading,
      required this.content,
      this.height = 97})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Row(
        children: [
          Expanded(flex: 1, child: leading),
          const SizedBox(
            width: 6,
          ),
          Expanded(flex: 2, child: content)
        ],
      ),
    );
  }
}
