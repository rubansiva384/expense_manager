// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ExpenseEntity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExpenseEntity _$ExpenseEntityFromJson(Map<String, dynamic> json) {
  return ExpenseEntity(
    name: json['name'] as String,
    description: json['description'] as String,
    dateTime: json['dateTime'] as int,
    amount: json['amount'] as int,
    type: json['type'] as int,
  );
}

Map<String, dynamic> _$ExpenseEntityToJson(ExpenseEntity instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'dateTime': instance.dateTime,
      'amount': instance.amount,
      'type': instance.type,
    };
