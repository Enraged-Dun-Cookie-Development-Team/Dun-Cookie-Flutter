import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_logkit/logkit.dart';

/// 打包版本开启日志：
/// flutter build apk --dart-define logging=true
const _enableLog = kDebugMode || bool.fromEnvironment('logging');

final logger = LogkitLogger(
  logkitSettings: LogkitSettings(
    disableAttachOverlay: !_enableLog,
    disableRecordLog: !_enableLog,
    printToConsole: true,
    maxLogCount: 500,
    entryIconBuilder: () => const _LogEntryIcon(),
    entryIconOffset: (screenSize, buttonSize) => Offset(
      screenSize.width - 20 - buttonSize.width,
      screenSize.height - 80 - buttonSize.height,
    ),
  ),
);

class _LogEntryIcon extends StatelessWidget {
  const _LogEntryIcon();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xff272727),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(2.0, 2.0),
            blurRadius: 8.0,
            spreadRadius: 4.0,
          ),
        ],
      ),
      padding: const EdgeInsets.all(8),
      child: Image.asset(
        height: 36,
        width: 36,
        'assets/image/logo_rhine.png',
      ),
    );
  }
}
