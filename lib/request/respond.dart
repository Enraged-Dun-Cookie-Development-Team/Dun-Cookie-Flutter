import '../model/json.dart';
import 'request.dart';

// ignore: constant_identifier_names
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
  final MapToModel<T> fromJson;
  final RequestType type;

  T? get data {
    final innerData = type == RequestType.cdn ? _data : _data?['data'];
    if (innerData is Map<String, dynamic>) {
      return fromJson(innerData);
    } else if (innerData is List<dynamic>) {
      return fromJson({'row': innerData});
    }
    return null;
  }

  T? get rawData => _data;

  String get code => _data['code'] ?? '';

  static failure({String? msg}) => ResponseData(
      data: false, fromJson: (_) => false, error: true, msg: msg ?? '');
}

MapToModel<List<T>> getListHandle<T, E>({ValueToModel<T, E>? fromJson}) {
  return (data) {
    List<T> result = [];
    final value = data['row'];
    if (value is List<T>) {
      return value;
    } else if (fromJson != null && value is List) {
      for (var element in value) {
        if (element is E) {
          result.add(fromJson(element));
        }
      }
    }
    return result;
  };
}
