import 'package:dun_cookie_flutter/common/tool/color_theme.dart';
import 'package:dun_cookie_flutter/request/user_request.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

import '../../common/tool/open_app_or_browser.dart';
import '../../model/bilibili_favorites_data.dart';
import '../../model/bilibili_user_favlist_data.dart';
import '../Error/main.dart';

class UserWanCard extends StatefulWidget {
  UserWanCard(this.favData, {Key? key}) : super(key: key);

  final FavData favData; // 粗略的数据 只有id

  @override
  State<UserWanCard> createState() => _UserWanCardState();
}

class _UserWanCardState extends State<UserWanCard> {
  bool _isExpanded = false;
  BilibiliFavoritesData favoritesData =
      BilibiliFavoritesData(); // 带详情的数据 包含视频列表
  //  加载状态 0一切正常 1正在加载 2加载失败
  int loadDataType = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: GestureDetector(
        onTap: () {
          setState(() {
            _isExpanded = !_isExpanded;
            _getFavData(widget.favData.id);
          });
        },
        child: Column(
          children: [
            ExpansionPanelList(
              elevation: 0,
              expansionCallback: (panelIndex, isExpanded) {
                setState(() {
                  _isExpanded = !isExpanded;
                });
              },
              children: <ExpansionPanel>[
                ExpansionPanel(
                  headerBuilder: (context, isExpanded) {
                    return Container(
                      alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.only(left: 10),
                      child: Text(widget.favData.title!),
                    );
                  },
                  body: favoritesData.data == null
                      ? const Center(child: Text("Loading……"))
                      : Padding(
                          padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Wrap(
                                crossAxisAlignment: WrapCrossAlignment.start,
                                children: List.generate(
                                    favoritesData.data!.medias!.length,
                                    (index) {
                                  return GestureDetector(
                                    child: Column(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          child: ExtendedImage.network(
                                            favoritesData
                                                .data!.medias![index].cover!,
                                            height: 100,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            favoritesData
                                                .data!.medias![index].title!,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 3,
                                            style: DunStyles.text14,
                                          ),
                                        )
                                      ],
                                    ),
                                    onTap: () {
                                      OpenAppOrBrowser.openUrl(
                                          "https://m.bilibili.com/video/${favoritesData.data!.medias![index].bvid}",
                                          context,
                                          appUrlScheme: favoritesData
                                              .data!.medias![index].link);
                                    },
                                  );
                                }),
                              )
                            ],
                          ),
                        ),
                  isExpanded: _isExpanded,
                ),
              ],
              animationDuration: kThemeAnimationDuration,
            ),
          ],
        ),
      ),
    );
  }

  //  获取数据
  _getFavData(id) async {
    setState(() {
      loadDataType = 1;
    });
    BilibiliFavoritesData data = BilibiliFavoritesData();
    if (widget.favData.bilibiliFavoritesData != null) {
      data = widget.favData.bilibiliFavoritesData!;
    } else {
      data = await UserRequest.getUserFav(id);
    }
    if (data.code == 0) {
      widget.favData.bilibiliFavoritesData = data;
      setState(() {
        favoritesData = data;
        loadDataType = 0;
      });
    } else {
      setState(() {
        loadDataType = 2;
      });
      DunError(error: "B站服务器断开");
    }
  }
}
