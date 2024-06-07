import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../common/dun_color.dart';
import '../../manager/settingManager.dart';
import '../../model/config/config_datasource.dart';

class DatasourceItem extends StatelessWidget {
  final ConfigDatasourceModel datasourceModel;
  final RxBool isSelected;
  final bool Function(ConfigDatasourceModel datasource, bool value)
      onTapDatasource;

  DatasourceItem(
      {super.key, required this.datasourceModel, required this.onTapDatasource})
      : isSelected = SettingManager.getInstance()
            .datasourceSetting
            .value
            .datasourceList
            .contains(datasourceModel.uniqueId)
            .obs;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
      color: DunColors.white,
      child: Row(
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: ExtendedImage.network(
                datasourceModel.avatar,
                width: 30,
                cache: true,
              )),
          const SizedBox(width: 8),
          Text(datasourceModel.nickname),
          const Spacer(),
          Obx(() => Checkbox(
                //数据源页复选框
                activeColor: DunColors.DunColor,
                value: isSelected.value,
                onChanged: (bool? value) {
                  if (value != null) {
                    isSelected.value = onTapDatasource(datasourceModel, value);
                  }
                },
              ))
        ],
      ),
    );
  }
}
