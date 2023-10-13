import 'package:dun_cookie_flutter/common/tool/color_theme.dart';
import 'package:dun_cookie_flutter/common/tool/dun_toast.dart';
import 'package:dun_cookie_flutter/model/config_datasource_model.dart';
import 'package:flutter/material.dart';

class SetUpItem extends StatefulWidget {
  final List<String> userSelectedList;
  final ConfigDatasourceModel data;
  const SetUpItem(
      {required this.userSelectedList, required this.data, Key? key})
      : super(key: key);

  @override
  State<SetUpItem> createState() => _SetUpItemState();
}

class _SetUpItemState extends State<SetUpItem> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    isChecked = widget.userSelectedList.contains(widget.data.uniqueId);
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
      color: white,
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Image.network(
              widget.data.avatar!,
              width: 30,
            ),
          ),
          const SizedBox(width: 8),
          Text(widget.data.nickname ?? ""),
          const Expanded(child: SizedBox()),
          Checkbox(
            //数据源页复选框
            activeColor: DunColors.DunColor,
            value: isChecked,
            onChanged: (value) {
              if (value != true && widget.userSelectedList.length == 1) {
                DunToast.showError("至少关注一个哦");
              } else {
                setState(() {
                  if (value == true) {
                    // 添加当前
                    isChecked = true;
                    widget.userSelectedList.add(widget.data.uniqueId!);
                  } else {
                    // 删除当前
                    isChecked = false;
                    widget.userSelectedList.remove(widget.data.uniqueId);
                  }
                });
              }
            },
          )
        ],
      ),
    );
  }
}
