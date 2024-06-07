import '../../model/config/config_datasource.dart';

class DatasourceState {

  // 获取所有数据源列表列表
  Map<Platform, List<ConfigDatasourceModel>> datasourceGroups = {};

  //获取用户数据源列表
  Set<String> userDatasourceList = {};


  String groupGID = 'groupGID';
  DatasourceState() {
    ///Initialize variables
  }
}
