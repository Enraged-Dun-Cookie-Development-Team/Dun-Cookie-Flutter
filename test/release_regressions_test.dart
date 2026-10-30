import 'package:dun_cookie_flutter/common/package_info.dart';
import 'package:dun_cookie_flutter/common/time_unit.dart';
import 'package:dun_cookie_flutter/widget/lazy_indexed_stack.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
      'version comparison accepts missing segments and rejects malformed versions',
      () {
    expect(PackageInfoPlus.isVersionHigher('1.0.3', '1.0.2'), isTrue);
    expect(PackageInfoPlus.isVersionHigher('1.0.1', '1.0'), isTrue);
    expect(PackageInfoPlus.isVersionHigher('1.0.0', '1.0'), isFalse);
    expect(PackageInfoPlus.isVersionHigher('1.0.2', '1.0.3'), isFalse);
    expect(PackageInfoPlus.isVersionHigher('invalid', '1.0.2'), isFalse);
  });

  test('malformed server dates do not throw during rendering', () {
    expect(TimeUnit.isTimeRange(DateTime.now(), '', 'bad'), isFalse);
    expect(TimeUnit.tryParseDateTime('bad'), isNull);
    expect(TimeUnit.timestampFormatYMD(8640000000000001), '未知日期');
  });

  testWidgets('lazy stack handles empty, null and out-of-range indexes',
      (tester) async {
    for (final index in <int?>[0, 1, -1, null]) {
      await tester
          .pumpWidget(MaterialApp(home: LazyIndexedStack(index: index)));
      expect(tester.takeException(), isNull);
    }
    await tester.pumpWidget(const MaterialApp(
        home: LazyIndexedStack(
      index: 1,
      children: [Text('first')],
    )));
    expect(tester.takeException(), isNull);
    await tester.pumpWidget(const MaterialApp(
        home: LazyIndexedStack(
      index: 0,
      children: [Text('first')],
    )));
    expect(find.text('first'), findsOneWidget);
  });
}
