import 'package:dun_cookie_flutter/common/tool/color_theme.dart';
import 'package:dun_cookie_flutter/main_page/common_ui/container_with_label.dart';
import 'package:dun_cookie_flutter/main_page/main_list/ui/main_list_item_card.dart';
import 'package:dun_cookie_flutter/model/setting_data.dart';
import 'package:dun_cookie_flutter/model/source_data.dart';
import 'package:dun_cookie_flutter/provider/setting_provider.dart';
import 'package:dun_cookie_flutter/request/list_request.dart';
import 'package:flutter/cupertino.dart';

class MainListWidget extends StatefulWidget {
  const MainListWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MainListWidgetState();
}

class _MainListWidgetState extends State<MainListWidget> {
  SettingProvider settingProvider = SettingProvider();
  SettingData? settingData;
  List<SourceData>? data;

  @override
  void initState() {
    super.initState();
    settingData = settingProvider.appSetting;
    fetchData();
  }

  void fetchData() async {
    data = await ListRequest.canteenCardList(
        source: {"source": settingData?.checkSource?.join("_") ?? ""});
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
      child: Column(
        children: [
          _buildTitleBar(),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return MainListItemCard(
                  data: data?[index],
                  settingData: settingData,
                );
              },
              itemCount: data?.length,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitleBar() {
    return SizedBox(
      height: 42,
      child: Row(
        children: [
          const ContainerWithLabel(
            text: "小刻食堂",
            containerWidth: 90,
            labelColor: yellow,
          ),
          const SizedBox(width: 9),
          Expanded(
            child: Row(
              children: [
                Container(
                  width: 14,
                  color: gray_1,
                ),
                Expanded(
                  child: Container(
                    color: white,
                  ),
                ),
                Container(
                  width: 44,
                  color: gray_1,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
