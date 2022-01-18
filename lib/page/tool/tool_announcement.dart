import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

class ToolAnnouncement extends StatelessWidget {
  const ToolAnnouncement({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      margin: const EdgeInsets.all(6),
      child: Swiper(
        itemBuilder: (c, i) {
          return const Card(
            child: Center(
              child: Text("公告"),
            ),
          );
        },
        // autoplay: true,
        itemCount: 1,
        pagination: const SwiperPagination(),
      ),
    );
  }
}
