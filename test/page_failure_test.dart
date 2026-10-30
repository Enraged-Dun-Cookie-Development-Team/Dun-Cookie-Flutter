import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:dun_cookie_flutter/page/manga/logic.dart';
import 'package:dun_cookie_flutter/page/more/logic.dart';
import 'package:dun_cookie_flutter/page/more/view.dart';
import 'package:dun_cookie_flutter/request/request.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

class FakeAdapter implements HttpClientAdapter {
  FakeAdapter(this.respond);
  final FutureOr<ResponseBody> Function(RequestOptions) respond;

  @override
  Future<ResponseBody> fetch(RequestOptions options,
      Stream<Uint8List>? requestStream, Future<void>? cancelFuture) async {
    return respond(options);
  }

  @override
  void close({bool force = false}) {}
}

ResponseBody jsonResponse(Object? data, {int status = 200}) {
  return ResponseBody.fromString(
    jsonEncode({'code': status == 200 ? '00000' : 'G0003', 'data': data}),
    status,
    headers: {
      Headers.contentTypeHeader: [Headers.jsonContentType]
    },
  );
}

void main() {
  late HttpClientAdapter originalAdapter;
  setUp(() {
    Get.testMode = true;
    originalAdapter = HttpClass.dio.httpClientAdapter;
  });
  tearDown(() {
    Get.reset();
    HttpClass.dio.httpClientAdapter = originalAdapter;
  });

  for (final malformed in [false, true]) {
    testWidgets(
        'More page survives ${malformed ? 'malformed data' : 'HTTP 500'}',
        (tester) async {
      tester.view.physicalSize = const Size(375, 812);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      HttpClass.dio.httpClientAdapter = FakeAdapter((_) => malformed
          ? jsonResponse({
              'updated_time': 'invalid',
              'daily': {'datetime': 42}
            })
          : jsonResponse(null, status: 500));
      await tester.pumpWidget(ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (_, __) => const GetMaterialApp(
          home: Scaffold(body: MorePage()),
        ),
      ));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
      expect(find.byType(ErrorWidget), findsNothing);
      expect(find.text('常用工具&推荐'), findsOneWidget);
      expect(find.text('暂时还没有漫画更新'), findsOneWidget);
    });
  }

  test('More loading waits for requests and repeated loads replace lists',
      () async {
    final gate = Completer<void>();
    HttpClass.dio.httpClientAdapter = FakeAdapter((options) async {
      if (options.path.endsWith('toolLink/list')) {
        await gate.future;
        return jsonResponse([
          {
            'localized_name': {'zh_CN': '工具'}
          }
        ]);
      }
      return jsonResponse(null);
    });
    final logic = MoreLogic();
    var finished = false;
    final loading = logic.loadData().then((_) => finished = true);
    await Future<void>.delayed(Duration.zero);
    expect(finished, isFalse);
    gate.complete();
    await loading;
    expect(logic.state.quickJumpList.length, 1);
    await logic.loadData();
    expect(logic.state.quickJumpList.length, 1);
    logic.onClose();
  });

  test('Manga HTTP failure leaves the loading state', () async {
    HttpClass.dio.httpClientAdapter =
        FakeAdapter((_) => jsonResponse(null, status: 500));
    final logic = MangaLogic();
    await logic.loadData();
    expect(logic.state.loadDataType.value, 2);
  });
}
