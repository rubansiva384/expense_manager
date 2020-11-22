part of 'add_expense_bloc.dart';

@immutable
abstract class AddExpenseEvent {

}

class EventAddBill extends AddExpenseEvent{
  final String name;
  final String description;
  final String amount;
  final String category;
  final int type;
  final int time;

  EventAddBill({this.name , this.category , this.amount , this.description , this.type , this.time});
}