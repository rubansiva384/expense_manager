// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AnalyticsEntity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnalyticsEntity _$AnalyticsEntityFromJson(Map<String, dynamic> json) {
  return AnalyticsEntity(
    category: json['expense_category'] as int,
    total: json['expense_total'] as int,
    countOfCategory: json['expense_row_count'] as int,
  )
    ..time = json['entered_time'] as int
    ..name = json['expense_description'] as String;
}

Map<String, dynamic> _$AnalyticsEntityToJson(AnalyticsEntity instance) =>
    <String, dynamic>{
      'expense_category': instance.category,
      'expense_row_count': instance.countOfCategory,
      'expense_total': instance.total,
      'entered_time': instance.time,
      'expense_description': instance.name,
    };
