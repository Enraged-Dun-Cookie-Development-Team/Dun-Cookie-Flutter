import 'package:animate_do/animate_do.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:dun_cookie_flutter/model/bakery_data.dart';
import 'package:dun_cookie_flutter/page/bakery/bakery_card.dart';
import 'package:dun_cookie_flutter/provider/common_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Bakery extends StatefulWidget {
  const Bakery({Key? key}) : super(key: key);
  static String routeName = "/bakery";

  @override
  State<Bakery> createState() => _BakeryState();
}

class _BakeryState extends State<Bakery> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: AppBar(
            titleSpacing: 0,
            bottom: const TabBar(
              tabs: [
                Tab(
                  text: "饼组预测",
                ),
                Tab(
                  text: "轮换饼学",
                ),
              ],
              indicatorColor: Colors.white,
              labelColor: Colors.white,
            ),
          ),
        ),
        body: TabBarView(
          children: [
            Selector<CommonProvider, List<BakeryData>>(
              builder: (ctx, list, child) {
                return Swiper(
                  itemBuilder: (BuildContext context, int index) {
                    return FadeIn(
                      child: Card(
                        margin: const EdgeInsets.all(20),
                        elevation: 15.0,
                        child: BakeryCard(list[index]),
                      ),
                    );
                  },
                  loop: false,
                  itemCount: list.length,
                  // pagination: SwiperPagination(),
                  // control: SwiperControl(),
                );
              },
              selector: (ctx, commonProvider) {
                return commonProvider.bakeryData;
              },
            ),
            Text("轮换学"),
          ],
        ),
      ),
    );
  }
}
