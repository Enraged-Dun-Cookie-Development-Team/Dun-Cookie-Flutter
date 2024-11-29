import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/dun_color.dart';
import '../../widget/manga/mange_list_card.dart';
import 'logic.dart';

class MangaPage extends StatelessWidget {
  MangaPage({Key? key}) : super(key: key);

  final logic = Get.put(MangaLogic());
  final state = Get.find<MangaLogic>().state;

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
        data: MediaQuery.of(context)
            .copyWith(textScaler: const TextScaler.linear(1.0)),
        child: Scaffold(
          backgroundColor: DunColors.gray_3,
          appBar: AppBar(
            //官方漫画页面
            backgroundColor: Colors.white,
            leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: logic.onTapBack),
            leadingWidth: 50,
            iconTheme: const IconThemeData(
              color: DunColors.DunColor,
            ),
            titleTextStyle:
                const TextStyle(color: DunColors.DunColor, fontSize: 20),
            titleSpacing: 0,
            title: const Text("官方漫画"),
          ),
          body: Container(
            color: DunColors.gray_3,
            child: _buildBody(),
          ),
        ));
  }

  _buildBody() {
    return Obx(() {
      if (state.loadDataType.value == 0) {
        return ListView.builder(
          itemCount: state.comicsList.length,
          itemBuilder: (ctx, index) {
            return FadeIn(
              duration: const Duration(milliseconds: 1000),
              child: MangaListCard(
                comicModel: state.comicsList[index],
                onTapEpisode: logic.onTapManga,
              ),
            );
          },
        );
      } else if (state.loadDataType.value == 1) {
        return const Center(
          child: Text("这是精美的加载动画"),
        );
      } else {
        return GestureDetector(
          onTap: logic.loadData,
          child: const Center(
            child: Text("这是难受的报错动画"),
          ),
        );
      }
    });
  }
}
