import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../common/dun_color.dart';
import '../../model/config/config_datasource.dart';
import 'datasource_item.dart';

class DataSourceGroupWidget extends StatelessWidget {
  final Platform platform;
  final List<ConfigDatasourceModel> datasourceList;
  final bool Function(ConfigDatasourceModel datasource, bool value)
      onTapDatasource;

  const DataSourceGroupWidget(
      {super.key,
      required this.platform,
      required this.datasourceList,
      required this.onTapDatasource});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: REdgeInsets.fromLTRB(13, 10, 0, 10),
          child: Text(
            platform.name,
            style: const TextStyle(
              color: Color(0xFF969696),
              fontSize: 14,
            ),
          ),
        ),
        Container(
          margin: REdgeInsets.fromLTRB(10, 0, 10, 0),
          decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Color(0x29000000),
                offset: Offset(0, 3),
                blurRadius: 5,
              ),
            ],
            color: DunColors.white,
          ),
          child: ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return DatasourceItem(
                datasourceModel: datasourceList[index],
                onTapDatasource: onTapDatasource,
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const Divider(
                height: 1,
                indent: 7,
                endIndent: 7,
              );
            },
            itemCount: datasourceList.length,
          ),
        ),
      ],
    );
  }
}
