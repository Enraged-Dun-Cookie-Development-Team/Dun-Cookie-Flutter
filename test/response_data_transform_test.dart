import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dun_cookie_flutter/request/respond.dart';

void main() {
  final errorModel = _TestModel(id: 0, name: '', likes: []);

  group('toModel', () {
    test('转换正常', () {
      final data = ResponseData(
        error: false,
        data: {
          "data": {
            "id": 1,
            "name": "u1",
            "likes": ["apple"]
          },
        },
        msg: '',
      ).toModel<_TestModel>(
        transform: _TestModel.fromMap,
        onError: () => errorModel,
      );

      expect(
        data,
        _TestModel(id: 1, name: "u1", likes: ["apple"]),
      );
    });

    test('error为true', () {
      expect(
        ResponseData(error: true, data: null, msg: '404').toModel<_TestModel>(
          transform: _TestModel.fromMap,
          onError: () => errorModel,
        ),
        errorModel,
      );
    });

    test('error为false，但data为null', () {
      expect(
        ResponseData(error: false, data: null, msg: '404').toModel<_TestModel>(
          transform: _TestModel.fromMap,
          onError: () => errorModel,
        ),
        errorModel,
      );
    });

    test('data类型不匹配', () {
      expect(
        ResponseData(error: false, data: 1, msg: '').toModel<_TestModel>(
          transform: _TestModel.fromMap,
          onError: () => errorModel,
        ),
        errorModel,
      );
    });

    test('data为空map', () {
      expect(
        ResponseData(error: false, data: {}, msg: '').toModel<_TestModel>(
          transform: _TestModel.fromMap,
          onError: () => errorModel,
        ),
        errorModel,
      );
    });
  });

  group('toModelList', () {
    test('转换正常', () {
      final data = ResponseData(
        error: false,
        data: {
          "data": [
            {
              "id": 1,
              "name": "u1",
              "likes": ["apple"]
            },
            {
              "id": 2,
              "name": "u2",
              "likes": ["pear"]
            }
          ],
        },
        msg: '',
      ).toModelList<_TestModel>(
        transform: _TestModel.fromMap,
        onError: () => [],
      );

      expect(data.length, 2);
    });

    test('data为null', () {
      expect(
        ResponseData(error: false, data: null, msg: '')
            .toModelList<_TestModel>(
              transform: _TestModel.fromMap,
              onError: () => [],
            )
            .length,
        0,
      );
    });

    test('内部data为null', () {
      expect(
        ResponseData(
                error: false,
                data: {
                  "data": null,
                },
                msg: '')
            .toModelList<_TestModel>(
              transform: _TestModel.fromMap,
              onError: () => [],
            )
            .length,
        0,
      );
    });

    test('列表元素类型不匹配', () {
      expect(
        ResponseData(
                error: false,
                data: {
                  "data": [1, 2],
                },
                msg: '')
            .toModelList<_TestModel>(
              transform: _TestModel.fromMap,
              onError: () => [],
            )
            .length,
        0,
      );
    });

    test('列表第一个元素部分字段类型不匹配', () {
      final data = ResponseData(
        error: false,
        data: {
          "data": [
            {
              "id": 1,
              "name": 2,
              "likes": ["apple"]
            },
            {
              "id": 2,
              "name": "u2",
              "likes": ["pear"]
            }
          ],
        },
        msg: '',
      ).toModelList<_TestModel>(
        transform: _TestModel.fromMap,
        onError: () => [],
      );

      expect(
        data,
        [
          _TestModel(id: 2, name: "u2", likes: ["pear"]),
        ],
      );
    });
  });

  group('toValue', () {
    test('error为true', () {
      expect(
        ResponseData(error: true, data: {"data": 1}, msg: '').toValue<int>(),
        null,
      );
      expect(
        ResponseData(error: true, data: {"data": 1}, msg: '')
            .toValue<int>(onError: () => -1),
        -1,
      );
    });

    test('类型不匹配', () {
      expect(
        ResponseData(error: false, data: {"data": 'fail'}, msg: '')
            .toValue<int>(onError: () => -1),
        -1,
      );
    });

    test('toValue<int>', () {
      expect(
        ResponseData(error: false, data: {"data": 1}, msg: '')
            .toValue<int>(onError: () => -1),
        1,
      );
    });

    test('toValue<bool>', () {
      expect(
        ResponseData(error: false, data: {"data": true}, msg: '')
            .toValue<bool>(onError: () => false),
        true,
      );
    });

    test('toValue<num>', () {
      expect(
        ResponseData(error: false, data: {"data": 3.14159}, msg: '')
            .toValue<num>(onError: () => 0),
        3.14159,
      );
    });

    test('toValue<String>', () {
      expect(
        ResponseData(error: false, data: {"data": 'world'}, msg: '')
            .toValue<String>(onError: () => ''),
        'world',
      );
    });
  });

  group('toValueList', () {
    test('error为true', () {
      expect(
        ResponseData(
          error: true,
          data: {
            "data": [1, 2, 3]
          },
          msg: '',
        ).toValueList<int>(onError: () => []),
        [],
      );
    });

    test('data为null', () {
      expect(
        ResponseData(error: false, data: null, msg: '')
            .toValueList<int>(onError: () => []),
        [],
      );
    });

    test('内部data为null', () {
      expect(
        ResponseData(error: false, data: null, msg: '')
            .toValueList<int>(onError: () => []),
        [],
      );
    });

    test('toValueList<int>', () {
      expect(
        ResponseData(
          error: false,
          data: {
            "data": [1, 2, 3]
          },
          msg: '',
        ).toValueList<int>(onError: () => []),
        [1, 2, 3],
      );
    });

    test('toValueList<String>', () {
      expect(
        ResponseData(
          error: false,
          data: {
            "data": ['abc', 'lmn', 'xyz']
          },
          msg: '',
        ).toValueList<String>(onError: () => []),
        ['abc', 'lmn', 'xyz'],
      );
    });
  });
}

class _TestModel {
  int id;
  String name;
  List<String> likes;

  _TestModel({
    required this.id,
    required this.name,
    required this.likes,
  });

  factory _TestModel.fromMap(Map<String, dynamic> json) => _TestModel(
        id: json["id"],
        name: json["name"],
        likes: List<String>.from(json["likes"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "likes": List<dynamic>.from(likes.map((x) => x)),
      };

  @override
  bool operator ==(covariant _TestModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        listEquals(other.likes, likes);
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ likes.hashCode;
}
