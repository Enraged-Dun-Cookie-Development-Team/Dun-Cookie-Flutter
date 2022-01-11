import 'package:card_swiper/card_swiper.dart';
import 'package:dun_cookie_flutter/page/bakery/bakery_card.dart';
import 'package:flutter/material.dart';

class Bakery extends StatelessWidget {
  const Bakery({Key? key}) : super(key: key);
  static String routeName = "/bakery";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Swiper(
      itemBuilder: (BuildContext context, int index) {
        return Card(
          elevation: 15.0,
          child: BakeryCard(),
        );
      },
      itemCount: 3,
      loop: false,
      // itemWidth: size.width,
      // itemHeight: size.height,
      // layout: SwiperLayout.TINDER,
      // pagination: SwiperPagination(),
      // control: SwiperControl(),
    );
  }
}
