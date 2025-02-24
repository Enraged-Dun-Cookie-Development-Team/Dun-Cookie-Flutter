import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'item_leading_widget.dart';

class ItemCard extends StatelessWidget {
  final ItemLeadingWidget leading;
  final Widget content;
  final double height;

  const ItemCard({
    super.key,
    required this.leading,
    required this.content,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Row(
        children: [
          Expanded(flex: 131, child: leading),
          SizedBox(width: 6.w),
          Expanded(flex: 220, child: content)
        ],
      ),
    );
  }
}
