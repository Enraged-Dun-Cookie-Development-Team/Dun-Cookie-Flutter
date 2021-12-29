import 'package:dun_cookie_flutter/generated/json/base/json_convert_content.dart';
import 'package:dun_cookie_flutter/model/source_data_entity.dart';

SourceDataEntity $SourceDataEntityFromJson(Map<String, dynamic> json) {
	final SourceDataEntity sourceDataEntity = SourceDataEntity();
	final String? dataSource = jsonConvert.convert<String>(json['dataSource']);
	if (dataSource != null) {
		sourceDataEntity.dataSource = dataSource;
	}
	final String? id = jsonConvert.convert<String>(json['id']);
	if (id != null) {
		sourceDataEntity.id = id;
	}
	final int? timeForSort = jsonConvert.convert<int>(json['timeForSort']);
	if (timeForSort != null) {
		sourceDataEntity.timeForSort = timeForSort;
	}
	final String? timeForDisplay = jsonConvert.convert<String>(json['timeForDisplay']);
	if (timeForDisplay != null) {
		sourceDataEntity.timeForDisplay = timeForDisplay;
	}
	final String? content = jsonConvert.convert<String>(json['content']);
	if (content != null) {
		sourceDataEntity.content = content;
	}
	final String? coverImage = jsonConvert.convert<String>(json['coverImage']);
	if (coverImage != null) {
		sourceDataEntity.coverImage = coverImage;
	}
	final String? jumpUrl = jsonConvert.convert<String>(json['jumpUrl']);
	if (jumpUrl != null) {
		sourceDataEntity.jumpUrl = jumpUrl;
	}
	final List<String>? imageList = jsonConvert.convertListNotNull<String>(json['imageList']);
	if (imageList != null) {
		sourceDataEntity.imageList = imageList;
	}
	final List<String>? imageHttpList = jsonConvert.convertListNotNull<String>(json['imageHttpList']);
	if (imageHttpList != null) {
		sourceDataEntity.imageHttpList = imageHttpList;
	}
	final String? componentData = jsonConvert.convert<String>(json['componentData']);
	if (componentData != null) {
		sourceDataEntity.componentData = componentData;
	}
	final SourceDataRetweeted? retweeted = jsonConvert.convert<SourceDataRetweeted>(json['retweeted']);
	if (retweeted != null) {
		sourceDataEntity.retweeted = retweeted;
	}
	final SourceDataSourceInfo? sourceInfo = jsonConvert.convert<SourceDataSourceInfo>(json['sourceInfo']);
	if (sourceInfo != null) {
		sourceDataEntity.sourceInfo = sourceInfo;
	}
	return sourceDataEntity;
}

Map<String, dynamic> $SourceDataEntityToJson(SourceDataEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['dataSource'] = entity.dataSource;
	data['id'] = entity.id;
	data['timeForSort'] = entity.timeForSort;
	data['timeForDisplay'] = entity.timeForDisplay;
	data['content'] = entity.content;
	data['coverImage'] = entity.coverImage;
	data['jumpUrl'] = entity.jumpUrl;
	data['imageList'] =  entity.imageList;
	data['imageHttpList'] =  entity.imageHttpList;
	data['componentData'] = entity.componentData;
	data['retweeted'] = entity.retweeted?.toJson();
	data['sourceInfo'] = entity.sourceInfo?.toJson();
	return data;
}

SourceDataRetweeted $SourceDataRetweetedFromJson(Map<String, dynamic> json) {
	final SourceDataRetweeted sourceDataRetweeted = SourceDataRetweeted();
	final String? name = jsonConvert.convert<String>(json['name']);
	if (name != null) {
		sourceDataRetweeted.name = name;
	}
	final String? content = jsonConvert.convert<String>(json['content']);
	if (content != null) {
		sourceDataRetweeted.content = content;
	}
	return sourceDataRetweeted;
}

Map<String, dynamic> $SourceDataRetweetedToJson(SourceDataRetweeted entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['name'] = entity.name;
	data['content'] = entity.content;
	return data;
}

SourceDataSourceInfo $SourceDataSourceInfoFromJson(Map<String, dynamic> json) {
	final SourceDataSourceInfo sourceDataSourceInfo = SourceDataSourceInfo();
	final String? icon = jsonConvert.convert<String>(json['icon']);
	if (icon != null) {
		sourceDataSourceInfo.icon = icon;
	}
	final String? dataName = jsonConvert.convert<String>(json['dataName']);
	if (dataName != null) {
		sourceDataSourceInfo.dataName = dataName;
	}
	final String? title = jsonConvert.convert<String>(json['title']);
	if (title != null) {
		sourceDataSourceInfo.title = title;
	}
	final String? dataUrl = jsonConvert.convert<String>(json['dataUrl']);
	if (dataUrl != null) {
		sourceDataSourceInfo.dataUrl = dataUrl;
	}
	final String? url = jsonConvert.convert<String>(json['url']);
	if (url != null) {
		sourceDataSourceInfo.url = url;
	}
	final int? priority = jsonConvert.convert<int>(json['priority']);
	if (priority != null) {
		sourceDataSourceInfo.priority = priority;
	}
	final int? uid = jsonConvert.convert<int>(json['uid']);
	if (uid != null) {
		sourceDataSourceInfo.uid = uid;
	}
	return sourceDataSourceInfo;
}

Map<String, dynamic> $SourceDataSourceInfoToJson(SourceDataSourceInfo entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['icon'] = entity.icon;
	data['dataName'] = entity.dataName;
	data['title'] = entity.title;
	data['dataUrl'] = entity.dataUrl;
	data['url'] = entity.url;
	data['priority'] = entity.priority;
	data['uid'] = entity.uid;
	return data;
}