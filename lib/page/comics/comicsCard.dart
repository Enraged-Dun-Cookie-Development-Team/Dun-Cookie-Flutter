import 'dart:ui';

import 'package:dun_cookie_flutter/common/tool/color_theme.dart';
import 'package:dun_cookie_flutter/model/source_data.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tags/flutter_tags.dart';

class ComicsCard extends StatefulWidget {
  ComicsCard(this.sourceData, {Key? key}) : super(key: key);

  final SourceData sourceData;

  @override
  State<ComicsCard> createState() => _ComicsCardState();
}

class _ComicsCardState extends State<ComicsCard> {
  bool _isExpanded = false;
  var episodes = [];

  @override
  void initState() {
    episodes = widget.sourceData.componentData!['episodes'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          ExtendedImage.network(
            widget.sourceData.coverImage!,
            fit: BoxFit.cover,
            handleLoadingProgress: true,
            clearMemoryCacheIfFailed: true,
            clearMemoryCacheWhenDispose: false,
            mode: ExtendedImageMode.gesture,
            cache: true,
            loadStateChanged: (ExtendedImageState state) {
              if (state.extendedImageLoadState == LoadState.loading) {
                return const Center(
                    child: Image(
                        image: AssetImage("assets/image/load/loading.gif")));
              }
            },
          ),
          ExpansionPanelList(
            elevation: 0,
            children: <ExpansionPanel>[
              ExpansionPanel(
                headerBuilder: (context, isExpanded) {
                  return Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.only(left: 10),
                    child: Text(
                        "共${episodes.length}章，最新于${widget.sourceData.timeForDisplay}更新"),
                  );
                },
                body: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.sourceData.content ?? "",
                        style: DunStyles.text16,
                      ),
                      Text(widget.sourceData.componentData!['introduction'],
                          style: DunStyles.text14B),
                      ListBody(
                        children: List.generate(episodes.length, (index){
                          return Text("${episodes[index]['shortTitle']}:${episodes[index]['title']}");
                        }),
                        // children: List.generate(episodes.length, (index) {
                        //   return ItemTags(
                        //     title: '不知道',
                        //     index: 0,
                        //   );
                        // }),
                      ),
                    ],
                  ),
                ),
                isExpanded: _isExpanded,
                canTapOnHeader: true,
              ),
            ],
            expansionCallback: (panelIndex, isExpanded) {
              setState(() {
                _isExpanded = !isExpanded;
              });
            },
            animationDuration: kThemeAnimationDuration,
          ),
        ],
      ),
    );
  }
}
