import 'package:expense_repository/src/database/database.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

part 'AnalyticsEntity.g.dart';

@JsonSerializable()
class AnalyticsEntity{
  @JsonKey(name: MyDatabase.COLUMN_EXPENSE_CATEGORY)
  final int category;

  @JsonKey(name: MyDatabase.COLUMN_EXPENSE_COUNT)
  final int countOfCategory;

  @JsonKey(name: MyDatabase.COLUMN_ANALYTICS_TOTAL)
  final int total;

  @JsonKey(name: MyDatabase.COLUMN_TIME)
  int time;

  @JsonKey(name: MyDatabase.COLUMN_EXPENSE_DESCRIPTION)
  String name;

  AnalyticsEntity({this.category , this.total , this.countOfCategory});

  factory AnalyticsEntity.fromJson(Map<String, dynamic> json) =>
      _$AnalyticsEntityFromJson(json);

  Map<String, dynamic> toJson() => _$AnalyticsEntityToJson(this);

  String get visibleAmount{
    final prefix = "- ";
    return "$prefix₹$total";
  }

  String get visibleTimeHome{
    final datetime  = time * 1000 ?? 0;
    final format = DateFormat("MMM '-'dd");
    return "${format.format(DateTime.fromMillisecondsSinceEpoch(datetime))}";
  }


}