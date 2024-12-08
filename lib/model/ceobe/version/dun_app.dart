import 'package:json_annotation/json_annotation.dart';

part 'dun_app.g.dart';

@JsonSerializable(createToJson: false)
class DunAppInfoModel {
  @JsonKey(defaultValue: '0.0.0')
  final String version;
  @JsonKey(name: 'previous_mandatory_version', defaultValue: '')
  final String previousMandatoryVersion;
  @JsonKey(defaultValue: '')
  final String description;
  @JsonKey(defaultValue: '')
  final String platform;
  @JsonKey(name: 'download_source', defaultValue: [])
  final List<DownloadSourceModel> downloadSources;

  DunAppInfoModel({
    required this.previousMandatoryVersion,
    required this.version,
    required this.description,
    required this.platform,
    required this.downloadSources,
  });

  factory DunAppInfoModel.fromJson(Map<String, dynamic> srcJson) =>
      _$DunAppInfoModelFromJson(srcJson);
}

@JsonSerializable(createToJson: false)
class DownloadSourceModel {
  @JsonKey(defaultValue: '')
  final String name;
  @JsonKey(defaultValue: '')
  final String description;
  @JsonKey(name: 'primary_url', fromJson: _fromJsonToDownloadUrlModel)
  final DownloadUrlModel primaryUrl;
  @JsonKey(name: 'spare_urls', defaultValue: [])
  final List<DownloadUrlModel> spareUrls;

  DownloadSourceModel({
    required this.name,
    required this.description,
    required this.primaryUrl,
    required this.spareUrls,
  });

  factory DownloadSourceModel.fromJson(Map<String, dynamic> srcJson) =>
      _$DownloadSourceModelFromJson(srcJson);
}

DownloadUrlModel _fromJsonToDownloadUrlModel(var srcJson) {
  if (srcJson is Map<String, dynamic>) {
    return DownloadUrlModel.fromJson(srcJson);
  } else {
    return DownloadUrlModel.fromJson({});
  }
}

@JsonSerializable(createToJson: false)
class DownloadUrlModel {
  @JsonKey(defaultValue: '')
  String name;
  @JsonKey(defaultValue: '')
  String url;
  @JsonKey(defaultValue: true)
  bool manual;
  @JsonKey(name: 'support_platforms', defaultValue: [])
  List<String> supportPlatforms;

  DownloadUrlModel({
    required this.name,
    required this.url,
    required this.manual,
    required this.supportPlatforms,
  });

  factory DownloadUrlModel.fromJson(Map<String, dynamic> srcJson) =>
      _$DownloadUrlModelFromJson(srcJson);
}
