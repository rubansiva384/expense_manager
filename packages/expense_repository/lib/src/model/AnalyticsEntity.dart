import 'package:expense_repository/src/database/database.dart';
import 'package:json_annotation/json_annotation.dart';

part 'AnalyticsEntity.g.dart';

@JsonSerializable()
class AnalyticsEntity{
  @JsonKey(name: MyDatabase.COLUMN_EXPENSE_CATEGORY)
  final int category;

  @JsonKey(name: MyDatabase.COLUMN_ANALYTICS_TOTAL)
  final int total;

  AnalyticsEntity({this.category , this.total});

  factory AnalyticsEntity.fromJson(Map<String, dynamic> json) =>
      _$AnalyticsEntityFromJson(json);

  Map<String, dynamic> toJson() => _$AnalyticsEntityToJson(this);

}