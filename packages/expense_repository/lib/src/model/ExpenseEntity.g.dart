// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ExpenseEntity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExpenseEntity _$ExpenseEntityFromJson(Map<String, dynamic> json) {
  return ExpenseEntity(
    description: json['expense_description'] as String,
    dateTime: json['entered_time'] as int,
    amount: json['expense_amount'] as int,
    type: json['expense_type'] as int,
    category: json['expense_category'] as int,
  );
}

Map<String, dynamic> _$ExpenseEntityToJson(ExpenseEntity instance) =>
    <String, dynamic>{
      'expense_description': instance.description,
      'entered_time': instance.dateTime,
      'expense_amount': instance.amount,
      'expense_type': instance.type,
      'expense_category': instance.category,
    };
