import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../common/dun_color.dart';
import '../../manager/setting_manager.dart';
import '../../model/config/config_datasource.dart';
import '../image/dun_image.dart';

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
      padding: REdgeInsets.fromLTRB(16, 8, 8, 8),
      color: DunColors.white,
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: DunImage.network(
              datasourceModel.avatar,
              width: 30,
              height: 30,
            ),
          ),
          const SizedBox(width: 8),
          Text(datasourceModel.nickname),
          const Spacer(),
          Obx(() => Checkbox(
                //数据源页复选框
                activeColor: DunColors.dunColor,
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
