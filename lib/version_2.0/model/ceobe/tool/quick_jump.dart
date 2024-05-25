import 'package:json_annotation/json_annotation.dart';

part 'quick_jump.g.dart';

@JsonSerializable()
class QuickJumpModel {
  final String url;
  final String name;
  final String img;

  QuickJumpModel({required this.url, required this.name, required this.img});

  factory QuickJumpModel.fromJson(Map<String, dynamic> srcJson) =>
      _$QuickJumpModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$QuickJumpModelToJson(this);
}
