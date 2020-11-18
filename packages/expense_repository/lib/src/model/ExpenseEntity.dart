import 'package:json_annotation/json_annotation.dart';

part 'ExpenseEntity.g.dart';

@JsonSerializable()
class ExpenseEntity{
static const TYPE_CREDIT = true;
static const TYPE_DEBIT = false;

  final String name;
  final String description;
  final int dateTime;
  final int amount;
  final int type;

  ExpenseEntity({this.name , this. description , this.dateTime , this.amount , this.type});

  factory ExpenseEntity.fromJson(Map<String, dynamic> json) => _$ExpenseEntityFromJson(json);
  Map<String, dynamic> toJson() => _$ExpenseEntityToJson(this);


}