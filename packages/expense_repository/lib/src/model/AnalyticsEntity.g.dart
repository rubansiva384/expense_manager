// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AnalyticsEntity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnalyticsEntity _$AnalyticsEntityFromJson(Map<String, dynamic> json) {
  return AnalyticsEntity(
    category: json['expense_category'] as int,
    total: json['expense_total'] as int,
  );
}

Map<String, dynamic> _$AnalyticsEntityToJson(AnalyticsEntity instance) =>
    <String, dynamic>{
      'expense_category': instance.category,
      'expense_total': instance.total,
    };
