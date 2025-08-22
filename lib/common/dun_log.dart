import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:share_plus/share_plus.dart';

class DunLog {
  // flutter build apk --dart-define logging=true
  static bool enableLogging =
      kDebugMode || const bool.fromEnvironment('logging');

  static final _logOutPut = _LogOutPut(maxLines: 1500);

  static final _logger = Logger(
    printer: PrettyPrinter(),
    output: _logOutPut,
  );

  static void info(dynamic message) {
    _logger.i(message);
  }

  static void error(
    dynamic message, [
    Object? error,
    StackTrace? stackTrace,
  ]) {
    _logger.e(message, error: error, stackTrace: stackTrace);
  }

  static void share() async {
    final dir = await getTemporaryDirectory();
    final fileName = 'dunapp_log_${DateTime.now().millisecondsSinceEpoch}.txt';
    final file = await File(p.join(dir.path, 'dunapp', fileName))
        .create(recursive: true);
    await file.writeAsString(_logOutPut.records.join('\n'));
    Share.shareXFiles([XFile(file.path)]).then((_) => file.delete());
  }
}

class _LogOutPut extends LogOutput {
  List<String> records = [];
  final int maxLines;

  _LogOutPut({this.maxLines = 1500});

  final _ansiEscape = RegExp(r'\x1B\[[0-9;]*m');

  @override
  void output(OutputEvent event) {
    if (!DunLog.enableLogging) return;

    for (final line in event.lines) {
      debugPrint(line);
      // 移除彩色ANSI码
      records.add(line.replaceAll(_ansiEscape, ''));
      if (records.length > maxLines) {
        records = records.sublist(maxLines ~/ 3);
      }
    }
  }
}

R? runZonedGuardedWithLog<R>(
  R Function() body, {
  bool printToConsole = true,
  Map<Object?, Object?>? zoneValues,
  ZoneSpecification? zoneSpecification,
}) {
  FlutterError.onError = (details) {
    DunLog.error('Flutter Error', details.exception, details.stack);
  };
  PlatformDispatcher.instance.onError = (err, stack) {
    DunLog.error('PlatformDispatcher Error', err, stack);
    return true;
  };
  return runZonedGuarded(
    body,
    (error, stack) {
      DunLog.error('Zone Error', error, stack);
    },
    zoneValues: zoneValues,
    zoneSpecification: zoneSpecification,
  );
}
