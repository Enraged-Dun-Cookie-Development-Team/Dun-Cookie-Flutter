import 'package:dun_cookie_flutter/model/manga/terra_recent_episode.dart';
import 'package:dun_cookie_flutter/request/request.dart';
import 'package:dun_cookie_flutter/request/respond.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('HTTP failures never parse the error payload as page data', () {
    final response = ResponseData<TerraRecentEpisodeModel>(
      data: {'code': 'G0003', 'data': null},
      error: true,
      fromJson: (_) => throw StateError('must not parse'),
    );
    expect(response.error, isTrue);
    expect(response.data, isNull);
    expect(response.code, 'G0003');
  });

  test('malformed response shapes and fields become errors', () {
    for (final payload in [
      '<html>Bad gateway</html>',
      {'data': 'invalid'},
      {
        'data': {'updated_time': 'not a number'}
      },
    ]) {
      final response = ResponseData<TerraRecentEpisodeModel>(
        data: payload,
        fromJson: TerraRecentEpisodeModel.fromJson,
      );
      expect(response.error, isTrue);
      expect(response.data, isNull);
    }
  });

  test('business errors retain their code and message', () {
    final response = ResponseData<Object>(
      data: {'code': 'C0018', 'message': 'already registered', 'data': null},
      fromJson: (json) => json,
    );
    expect(response.error, isTrue);
    expect(response.code, USER_HAS_CREATE);
    expect(response.msg, 'already registered');
  });

  test('data is parsed once and raw CDN responses are supported', () {
    var parses = 0;
    final response = ResponseData<int>(
      data: {'value': 3},
      type: RequestType.cdn,
      fromJson: (json) {
        parses++;
        return json['value'] as int;
      },
    );
    expect(response.data, 3);
    expect(response.data, 3);
    expect(parses, 1);
    expect(response.error, isFalse);
  });

  test('a malformed list item does not discard valid neighbors', () {
    final response = ResponseData<List<int>>(
      data: {
        'data': [
          {'n': 1},
          {'n': 'bad'},
          null,
          {'n': 2}
        ]
      },
      fromJson: getListHandle<int, Map<String, dynamic>>(
        fromJson: (json) => json['n'] as int,
      ),
    );
    expect(response.data, [1, 2]);
  });

  test('download failures and missing data are safe to inspect', () {
    final failure = ResponseData.failure(msg: 'offline');
    expect(failure.data, isNull);
    expect(failure.code, isEmpty);
    expect(failure.rawData, isFalse);
    final empty = ResponseData<TerraRecentEpisodeModel>(
      data: {'code': '00000', 'data': null},
      fromJson: TerraRecentEpisodeModel.fromJson,
    );
    expect(empty.error, isFalse);
    expect(empty.data, isNull);
  });
}
