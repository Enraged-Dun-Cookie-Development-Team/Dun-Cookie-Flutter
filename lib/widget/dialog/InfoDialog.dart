import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../common/dun_color.dart';

class InfoDialog extends Dialog {
  final String? title;
  final String? content;

  const InfoDialog({super.key, this.title, this.content});

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: _buildInfoDialog(context),
      ),
    );
  }

  Widget _buildInfoDialog(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      padding: REdgeInsets.only(top: 8, bottom: 15),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              title ?? "",
              style: const TextStyle(
                color: DunColors.DunColor,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.85,
              constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.width * 0.7),
              padding: REdgeInsets.only(top: 8, left: 15, right: 5),
              child: Scrollbar(
                thumbVisibility: false,
                child: SingleChildScrollView(
                    child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(content ?? ""),
                  ],
                )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
