part of 'add_expense_bloc.dart';

@immutable
abstract class AddExpenseEvent {

}

class EventAddBill extends AddExpenseEvent{
  final String name;
  final String description;
  final String amount;
  final int type;
  final String image;


  EventAddBill({this.name , this.amount , this.description , this.type ,this.image});
}

class AmountChanged extends AddExpenseEvent{
  final String amount;

  AmountChanged({this.amount});
}

class DescriptionChange extends AddExpenseEvent{
  final String desc;

  DescriptionChange({this.desc});
}

class NameChanged extends AddExpenseEvent{
  final String name;

  NameChanged({this.name});
}

class TimeChanged extends AddExpenseEvent{
  final int time;

  TimeChanged({this.time});
}

class CategoryChanged extends AddExpenseEvent{
  final int categoryId;

  CategoryChanged({ this.categoryId});
}