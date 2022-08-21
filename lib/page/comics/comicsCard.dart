
import 'package:dun_cookie_flutter/common/tool/color_theme.dart';
import 'package:dun_cookie_flutter/common/tool/dun_tag.dart';
import 'package:dun_cookie_flutter/common/tool/open_app_or_browser.dart';
import 'package:dun_cookie_flutter/model/source_data.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class ComicsCard extends StatefulWidget {
  const ComicsCard(this.sourceData, {Key? key}) : super(key: key);

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
      child: GestureDetector(
        onTap: () {
          setState(() {
            _isExpanded = !_isExpanded;
          });
        },
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
                          height: 220,
                          image: AssetImage("assets/image/load/loading.gif")));
                }
                return null;
              },
            ),
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
                      child: Text(
                          "共${episodes.length}章，最新于${widget.sourceData.timeForDisplay}更新"),
                    );
                  },
                  body: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: List.generate(
                              widget.sourceData.componentData!['keywords']
                                  .length, (index) {
                            return Container(
                              margin: const EdgeInsets.only(right: 5),
                              child: DunTag(widget.sourceData
                                  .componentData!['keywords'][index]),
                            );
                          }),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        Text(
                          widget.sourceData.content ?? "",
                          style: DunStyles.text16,
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        Text(widget.sourceData.componentData!['introduction'],
                            style: DunStyles.text14B),
                        const SizedBox(
                          height: 6,
                        ),
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.start,
                          children: List.generate(episodes.length, (index) {
                            return GestureDetector(
                              onTap: () {
                                OpenAppOrBrowser.openUrl(
                                    "https://terra-historicus.hypergryph.com/comic/${widget.sourceData.componentData!['cid']}/episode/${episodes[index]['cid']}",
                                    context);
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 2, horizontal: 8),
                                margin: const EdgeInsets.only(
                                    bottom: 10, right: 10),
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(color: DunColors.DunColor),
                                    borderRadius: BorderRadius.circular(5)),
                                child: Text(
                                    "${episodes[index]["shortTitle"] == null ? "" : episodes[index]["shortTitle"] + ":"}${episodes[index]["title"]}"),
                              ),
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
}
