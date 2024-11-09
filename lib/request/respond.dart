import 'package:dun_cookie_flutter/request/request.dart';

import '../model/json.dart';

const String USER_HAS_CREATE = "C0018";

class ResponseData<T> {
  ResponseData({
    required dynamic data,
    required this.fromJson,
    this.error = false,
    this.msg = '',
    this.type = RequestType.none,
  }) : _data = data;

  final bool error;
  final dynamic _data;
  final String msg;
  final MapToModel fromJson;
  final RequestType type;

  T? get data {
    final innerData = type == RequestType.cdn ? _data : _data['data'];
    if (innerData is Map<String, dynamic>) {
      return fromJson(innerData);
    } else if (innerData is List<dynamic>) {
      return fromJson({'row': innerData});
    }
    return null;
  }

  String get code => _data['code'] ?? '';
}

MapToModel<List<T>> getListHandle<T, E>({ValueToModel<T, E>? fromJson}) {
  return (data) {
    final value = data['row'];
    if (value is List<T>) {
      return value;
    } else if (fromJson != null && value is List<E>) {
      return value.map((e) => fromJson(e)).toList();
    }
    return [];
  };
}
