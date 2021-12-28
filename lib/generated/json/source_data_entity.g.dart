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
	final String? coverImage = jsonConvert.convert<String>(json['coverImage']);
	if (coverImage != null) {
		sourceDataEntity.coverImage = coverImage;
	}
	final bool? isTop = jsonConvert.convert<bool>(json['isTop']);
	if (isTop != null) {
		sourceDataEntity.isTop = isTop;
	}
	final SourceDataComponentData? componentData = jsonConvert.convert<SourceDataComponentData>(json['componentData']);
	if (componentData != null) {
		sourceDataEntity.componentData = componentData;
	}
	final SourceDataRetweeted? retweeted = jsonConvert.convert<SourceDataRetweeted>(json['retweeted']);
	if (retweeted != null) {
		sourceDataEntity.retweeted = retweeted;
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
	data['jumpUrl'] = entity.jumpUrl;
	data['imageList'] =  entity.imageList;
	data['imageHttpList'] =  entity.imageHttpList;
	data['coverImage'] = entity.coverImage;
	data['isTop'] = entity.isTop;
	data['componentData'] = entity.componentData.toJson();
	data['retweeted'] = entity.retweeted.toJson();
	return data;
}

SourceDataComponentData $SourceDataComponentDataFromJson(Map<String, dynamic> json) {
	final SourceDataComponentData sourceDataComponentData = SourceDataComponentData();
	return sourceDataComponentData;
}

Map<String, dynamic> $SourceDataComponentDataToJson(SourceDataComponentData entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
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