import '../common/dun_log.dart';
import '../model/json.dart';
import 'request.dart';

// ignore: constant_identifier_names
const String USER_HAS_CREATE = "C0018";

class ResponseData<T> {
  ResponseData({
    required dynamic data,
    required this.fromJson,
    bool error = false,
    String msg = '',
    this.type = RequestType.none,
  })  : _data = data,
        _error = error,
        _msg = msg {
    if (_error) return;
    if (type != RequestType.cdn && code.isNotEmpty && code != '00000') {
      _error = true;
      _msg = (_data as Map)['message']?.toString() ?? msg;
      return;
    }
    try {
      final dynamic innerData;
      if (type == RequestType.cdn) {
        innerData = _data;
      } else if (_data is Map) {
        innerData = _data['data'];
      } else if (_data == null || _data is bool) {
        return;
      } else {
        throw const FormatException('Expected a JSON response object');
      }
      if (innerData is Map<String, dynamic>) {
        _parsedData = fromJson(innerData);
      } else if (innerData is List) {
        _parsedData = fromJson({'row': innerData});
      } else if (innerData != null) {
        throw const FormatException('Expected a JSON object or list');
      }
    } catch (exception, stack) {
      _error = true;
      _msg = '响应数据格式异常';
      DunLog.error(_msg, exception, stack);
    }
  }

  bool _error;
  bool get error => _error;
  final dynamic _data;
  String _msg;
  String get msg => _msg;
  final MapToModel<T> fromJson;
  final RequestType type;

  T? _parsedData;
  T? get data => _parsedData;

  dynamic get rawData => _data;

  String get code => _data is Map ? _data['code']?.toString() ?? '' : '';

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
          try {
            result.add(fromJson(element));
          } catch (exception, stack) {
            DunLog.error('忽略格式错误的列表项', exception, stack);
          }
        }
      }
    }
    return result;
  };
}
