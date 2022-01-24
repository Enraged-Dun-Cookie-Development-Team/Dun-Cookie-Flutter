import 'package:animate_do/animate_do.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:dun_cookie_flutter/page/bakery/bakery_card.dart';
import 'package:flutter/material.dart';

class Bakery extends StatelessWidget {
  const Bakery({Key? key}) : super(key: key);
  static String routeName = "/bakery";

  @override
  Widget build(BuildContext context) {
    return Swiper(
      itemBuilder: (BuildContext context, int index) {
        return FadeIn(
          child: const Card(
            margin: EdgeInsets.all(20),
            elevation: 15.0,
            child: BakeryCard(),
          ),
        );
      },
      loop: false,
      itemCount: 1,
      // pagination: SwiperPagination(),
      // control: SwiperControl(),
    );
  }
}
