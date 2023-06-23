import 'dart:ffi';

/// "total_count": 78,
/// "skin_count": 2,
/// "operator_count": 0,
/// "activity_count": 6,
/// "ep_count": 0
class CookieInfoCountModel {
  CookieInfoCountModel({
    int? totalCount,
    int? skinCount,
    int? operatorCount,
    int? activityCount,
    int? epCount,
  }) {
    _totalCount = totalCount;
    _skinCount = skinCount;
    _operatorCount = operatorCount;
    _activityCount = activityCount;
    _epCount = epCount;
  }

  CookieInfoCountModel.fromJson(dynamic json) {
    _totalCount = json['total_count'];
    _skinCount = json['skin_count'];
    _operatorCount = json['operator_count'];
    _activityCount = json['activity_count'];
    _epCount = json['ep_count'];
  }
  int? _totalCount;
  int? _skinCount;
  int? _operatorCount;
  int? _activityCount;
  int? _epCount;
  CookieInfoCountModel copyWith({
    int? totalCount,
    int? skinCount,
    int? operatorCount,
    int? activityCount,
    int? epCount,
  }) =>
      CookieInfoCountModel(
        totalCount: totalCount ?? _totalCount,
        skinCount: skinCount ?? _skinCount,
        operatorCount: operatorCount ?? _operatorCount,
        activityCount: activityCount ?? _activityCount,
        epCount: epCount ?? _epCount,
      );
  int? get totalCount => _totalCount;
  int? get skinCount => _skinCount;
  int? get operatorCount => _operatorCount;
  int? get activityCount => _activityCount;
  int? get epCount => _epCount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['total_count'] = _totalCount;
    map['skin_count'] = _skinCount;
    map['operator_count'] = _operatorCount;
    map['activity_count'] = _activityCount;
    map['ep_count'] = _epCount;
    return map;
  }
}
