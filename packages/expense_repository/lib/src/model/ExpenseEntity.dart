import 'package:expense_repository/src/database/database.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';
part 'ExpenseEntity.g.dart';

@JsonSerializable()
class ExpenseEntity {
  static const TYPE_CREDIT = 1;
  static const TYPE_DEBIT = 2;

  @JsonKey(name: MyDatabase.COLUMN_EXPENSE_DESCRIPTION)
  final String description;
  @JsonKey(name: MyDatabase.COLUMN_TIME)
  final int dateTime;
  @JsonKey(name: MyDatabase.COLUMN_EXPENSE_AMOUNT)
  final int amount;
  @JsonKey(name: MyDatabase.COLUMN_EXPENSE_TYPE)
  final int type;
  @JsonKey(name: MyDatabase.COLUMN_EXPENSE_CATEGORY)
  final int category;

  ExpenseEntity(
      {this.description, this.dateTime, this.amount, this.type, this.category});

  factory ExpenseEntity.fromJson(Map<String, dynamic> json) =>
      _$ExpenseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ExpenseEntityToJson(this);

  String get visibleAmount{
    final prefix = type == TYPE_DEBIT ? "- " : "";
    return "$prefix₹$amount";
  }

  String get visibleTimeHome{
    final time  = dateTime * 1000 ?? 0;
    final format = DateFormat("MMM '-'dd");
    return "${format.format(DateTime.fromMillisecondsSinceEpoch(time))}";
  }

  int get date{
    final time  = dateTime ?? 0;
    final format = DateFormat("dd");
    return int.parse(format.format(DateTime.fromMillisecondsSinceEpoch(time)));
  }

}
