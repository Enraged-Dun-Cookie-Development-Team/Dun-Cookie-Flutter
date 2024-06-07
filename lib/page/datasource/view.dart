import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../common/dun_color.dart';
import '../../widget/datasource/datasource_group_widget.dart';
import 'logic.dart';

class DatasourcePage extends StatelessWidget {
  DatasourcePage({Key? key}) : super(key: key);

  final logic = Get.put(DatasourceLogic());
  final state = Get.find<DatasourceLogic>().state;

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        appBar: AppBar(
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
          // 为啥别人都没去就你去了 要去一起去
          // elevation: 0,
          title: const Text("饼来源"),
        ),
        body: Column(
          children: [
            Expanded(
              child: Container(
                color: DunColors.gray_3,
                child: SingleChildScrollView(
                  child: _buildBody(),
                ),
              ),
            ),
            _buildSaveButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    return GetBuilder<DatasourceLogic>(
      id: state.groupGID,
      builder: (logic) {
        List<Widget> body = [];
        state.datasourceGroups.forEach(
          (platform, datasourceList) {
            if (datasourceList.isNotEmpty) {
              body.add(
                DataSourceGroupWidget(
                  platform: platform,
                  datasourceList: datasourceList,
                  onTapDatasource: logic.onChangeDatasource,
                ),
              );
            }
          },
        );
        return Column(children: body);
      },
    );
  }

  Widget _buildSaveButton() {
    return GestureDetector(
      onTap: logic.onTapSave,
      child: Container(
        color: DunColors.white,
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: Container(
          height: 40,
          decoration: BoxDecoration(
            color: DunColors.DunColor,
            borderRadius: BorderRadius.circular(4),
          ),
          child: const Center(
              child: Text(
            "保存",
            style: TextStyle(
              color: DunColors.white,
              fontSize: 16,
            ),
          )),
        ),
      ),
    );
  }
}
