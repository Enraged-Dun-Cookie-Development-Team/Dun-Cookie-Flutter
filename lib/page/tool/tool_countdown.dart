import 'package:dun_cookie_flutter/common/pubilc.dart';
import 'package:dun_cookie_flutter/model/ceobecanteen_info.dart';
import 'package:flutter/material.dart';

class ToolCountdown extends StatelessWidget {
  ToolCountdown(this.countDown, {Key? key}) : super(key: key);

  final List<Countdown> countDown;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const Text(
            "活动倒计时",
            style: TextStyle(color: DunColors.DunColor, fontSize: 16),
          ),
          Card(
            child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: countDown.length >= 3 ? 3 : countDown.length,
                itemBuilder: (ctx, index) {
                  var info = countDown[index];
                  return Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "距离${info.text!}",
                              style: const TextStyle(fontSize: 18),
                            ),
                            const Text(
                              "剩余X天X小时X分钟",
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              info.remark!,
                              style: const TextStyle(color: Colors.black45),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
