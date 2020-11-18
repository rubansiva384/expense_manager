import 'package:expense_repository/src/database/database.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ExpenseEntity.g.dart';

@JsonSerializable()
class ExpenseEntity {
  static const TYPE_CREDIT = 1;
  static const TYPE_DEBIT = 2;

  @JsonKey(name: MyDatabase.COLUMN_EXPENSE_NAME)
  final String name;
  @JsonKey(name: MyDatabase.COLUMN_EXPENSE_DESCRIPTION)
  final String description;
  @JsonKey(name: MyDatabase.COLUMN_TIME)
  final int dateTime;
  @JsonKey(name: MyDatabase.COLUMN_EXPENSE_AMOUNT)
  final int amount;
  @JsonKey(name: MyDatabase.COLUMN_EXPENSE_TYPE)
  final int type;

  ExpenseEntity(
      {this.name, this.description, this.dateTime, this.amount, this.type});

  factory ExpenseEntity.fromJson(Map<String, dynamic> json) =>
      _$ExpenseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ExpenseEntityToJson(this);
}
