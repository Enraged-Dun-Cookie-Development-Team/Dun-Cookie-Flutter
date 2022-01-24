import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:dun_cookie_flutter/common/tool/color_theme.dart';
import 'package:dun_cookie_flutter/common/tool/time_unit.dart';
import 'package:dun_cookie_flutter/model/ceobecanteen_data.dart';
import 'package:flutter/material.dart';

class ToolCountdown extends StatelessWidget {
  ToolCountdown(List<Countdown> countDown, {Key? key}) {
    _countDown = countDown.where((timeDM) {
      return TimeUnit.isTimeRange(
          TimeUnit.utcChinaNow(), timeDM.starTime, timeDM.overTime);
    }).toList();
  }

  List<Countdown> _countDown = [];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          // const Text(
          //   "活动倒计时",
          //   style: TextStyle(color: DunColors.DunColor, fontSize: 16),
          // ),
          FadeInUp(
            child: Card(
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                // itemCount: countDown.length >= 3 ? 3 : countDown.length,
                itemCount: _countDown.length,
                itemBuilder: (ctx, index) {
                  var info = _countDown[index];
                  return FadeInRight(
                    delay: Duration(milliseconds: 50 * index),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 6, horizontal: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: SingleChildScrollView(
                                    child: RichText(
                                      text: TextSpan(
                                          text: "距离",
                                          style: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.black),
                                          children: [
                                            TextSpan(
                                              text: info.text!,
                                              style: const TextStyle(
                                                  color: DunColors.DunColor),
                                            )
                                          ]),
                                    ),
                                    scrollDirection: Axis.horizontal),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              TimeDiffText(info.time!),
                            ],
                          ),
                          Row(
                            children: [
                              SingleChildScrollView(
                                  child: Text(
                                    info.remark!,
                                    style:
                                        const TextStyle(color: Colors.black45),
                                  ),
                                  scrollDirection: Axis.horizontal),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

class TimeDiffText extends StatefulWidget {
  TimeDiffText(this.stopTime, {Key? key}) : super(key: key);

  String stopTime;

  @override
  _TimeDiffTextState createState() => _TimeDiffTextState();
}

class _TimeDiffTextState extends State<TimeDiffText> {
  late Timer _timer;
  String _timeText = "计算中……";

  @override
  void initState() {
    super.initState();
    setState(() {
      _timeText = TimeUnit.timeDiff(starTime: widget.stopTime);
    });
    _timer = Timer.periodic(const Duration(minutes: 1), (timer) {
      ///定时任务
      setState(() {
        _timeText = TimeUnit.timeDiff(starTime: widget.stopTime);
      });
    });
  }

  @override
  void dispose() {
    ///取消计时器
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _timeText,
      style: const TextStyle(fontSize: 14),
    );
  }
}
