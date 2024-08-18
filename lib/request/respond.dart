import 'package:flutter/foundation.dart';

class ResponseData {
  ResponseData({required this.error, required this.data, required this.msg});

  bool error = false;
  dynamic data;
  String msg = "";

  bool get isSuccess => msg == "";
}

extension ResponseDataTransformer on ResponseData {
  bool _isMap(dynamic value) => value is Map<String, dynamic>;
  bool _isNotMap(dynamic value) => !_isMap(value);

  R? _extractInnerData<R>() {
    if (error || _isNotMap(data)) return null;
    final innerData = data['data'];
    if (innerData is! R) return null;
    return innerData;
  }

  T toModel<T>({
    required T Function(Map<String, dynamic> json) transform,
    required T Function() onError,
  }) {
    final innerData = _extractInnerData<Map<String, dynamic>>();
    if (innerData == null) return onError();

    try {
      return transform(innerData);
    } catch (e) {
      return onError();
    }
  }

  List<T> toModelList<T>({
    required T Function(Map<String, dynamic> json) transform,
    List<T> Function()? onError,
  }) {
    final innerData = _extractInnerData<List>();
    if (innerData == null) return onError?.call() ?? [];

    List<T> list = [];
    for (final item in innerData) {
      if (_isNotMap(item)) continue;
      try {
        list.add(transform(item));
      } catch (e) {
        debugPrint(e.toString());
      }
    }
    return list;
  }

  T? toValue<T>({T? Function()? onError}) {
    final innerData = _extractInnerData<T>();
    if (innerData == null) return onError?.call();

    return innerData;
  }

  List<T> toValueList<T>({List<T> Function()? onError}) {
    final innerData = _extractInnerData<List<T>>();
    if (innerData == null) return onError?.call() ?? [];

    return innerData;
  }
}
