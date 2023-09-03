/// datasource_config : ["sunt et est quis","cupidatat elit veniam mollit"]
/// datasource_comb_id : "7"

class UserDatasourceSettings {
  UserDatasourceSettings({
    this.datasourceConfig,
    this.datasourceCombId,
  });

  UserDatasourceSettings.fromJson(dynamic json) {
    datasourceConfig = json['datasource_config'] != null
        ? json['datasource_config'].cast<String>()
        : [];
    datasourceCombId = json['datasource_comb_id'];
  }
  List<String>? datasourceConfig;
  String? datasourceCombId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['datasource_config'] = datasourceConfig;
    map['datasource_comb_id'] = datasourceCombId;
    return map;
  }
}
