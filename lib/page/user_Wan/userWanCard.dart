import 'package:animate_do/animate_do.dart';
import 'package:dun_cookie_flutter/common/tool/color_theme.dart';
import 'package:dun_cookie_flutter/request/user_request.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

import 'package:dun_cookie_flutter/common/tool/open_app_or_browser.dart';
import 'package:dun_cookie_flutter/model/bilibili_favorites_data.dart';
import 'package:dun_cookie_flutter/model/bilibili_user_favlist_data.dart';
import 'package:dun_cookie_flutter/page/error/main.dart';

class UserWanCard extends StatefulWidget {
  const UserWanCard(this.favData, {Key? key}) : super(key: key);

  final FavData favData; // 粗略的数据 只有id

  @override
  State<UserWanCard> createState() => _UserWanCardState();
}

class _UserWanCardState extends State<UserWanCard> {
  bool _isExpanded = false;
  BilibiliFavoritesData favoritesData =
      BilibiliFavoritesData(); // 带详情的数据 包含视频列表
  //  加载状态 0一切正常 1正在加载 2加载失败
  int loadDataType = 1;

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
          });
          _getFavData(widget.favData.id);
        },
        child: ExpansionPanelList(
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
                  child: Row(
                    children: [
                      const Image(
                        image: AssetImage("assets/sources_logo/bili.ico"),
                        height: 24,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(widget.favData.title!),
                    ],
                  ),
                );
              },
              body: loadDataType == 1
                  ? const Center(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("Loading……"),
                      ),
                    )
                  : loadDataType == 0
                      ? FadeIn(
                          duration: const Duration(milliseconds: 1000),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                            child: Column(
                              children: [
                                // Row(
                                //   children: [
                                //     ElevatedButton(
                                //         onPressed: () {}, child: Text("前往该收藏"))
                                //   ],
                                // ),
                                // const SizedBox(
                                //   height: 8,
                                // ),
                                GridView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount:
                                        favoritesData.data?.medias?.length,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            mainAxisSpacing: 2,
                                            crossAxisSpacing: 2,
                                            childAspectRatio: 1),
                                    itemBuilder: (ctx, index) {
                                      return GestureDetector(
                                        child: Card(
                                          child: Column(
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                                child: ExtendedImage.network(
                                                  favoritesData.data!
                                                      .medias![index].cover!,
                                                  height: 100,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  favoritesData.data!
                                                      .medias![index].title!,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 3,
                                                  style: DunStyles.text12,
                                                ),
                                              )
                                            ],
                                          ),
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
                              ],
                            ),
                          ),
                        )
                      : const Center(
                          child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text("卧槽 加载失败"),
                        )),
              isExpanded: _isExpanded,
            ),
          ],
          animationDuration: kThemeAnimationDuration,
        ),
      ),
    );
  }

  //  获取数据
  _getFavData(id) async {
    if (!_isExpanded) {
      return;
    }
    setState(() {
      loadDataType = 1;
    });
    BilibiliFavoritesData data = await UserRequest.getUserFav(id);
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
