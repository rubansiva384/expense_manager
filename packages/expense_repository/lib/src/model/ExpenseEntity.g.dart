// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ExpenseEntity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExpenseEntity _$ExpenseEntityFromJson(Map<String, dynamic> json) {
  return ExpenseEntity(
    name: json['expense_name'] as String,
    description: json['expense_description'] as String,
    dateTime: json['entered_time'] as int,
    amount: json['expense_amount'] as int,
    type: json['expense_type'] as int,
    image: json['expense_image'] as String,
  );
}

Map<String, dynamic> _$ExpenseEntityToJson(ExpenseEntity instance) =>
    <String, dynamic>{
      'expense_name': instance.name,
      'expense_description': instance.description,
      'entered_time': instance.dateTime,
      'expense_amount': instance.amount,
      'expense_type': instance.type,
      'expense_image': instance.image,
    };
