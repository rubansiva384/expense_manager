part of 'main_bloc.dart';

@immutable
abstract class MainEvent {}

class MainEventLoad extends MainEvent{
  final DateTime time;

  MainEventLoad({this.time});
}

class MainEventNewBill extends MainEvent{
  final ExpenseEntity expenseEntity;

  MainEventNewBill({this.expenseEntity});
}

class MainEventMonthChanged extends MainEvent{
  final DateTime time;

  MainEventMonthChanged({this.time});
}

