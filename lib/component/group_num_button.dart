import 'package:dun_cookie_flutter/common/tool/dun_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GroupNumButton extends StatelessWidget {
  const GroupNumButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Clipboard.setData(const ClipboardData(text: '362860473'));
        DunToast.showSuccess("已复制，来QQ群找我们升级吧！");
      },
      child: const Text(
        "群号：362860473，点击复制",
      ),
    );
  }
}
