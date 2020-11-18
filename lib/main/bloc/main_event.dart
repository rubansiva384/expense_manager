part of 'main_bloc.dart';

@immutable
abstract class MainEvent {}

class MainEventLoad extends MainEvent{

}

class MainEventNewBill extends MainEvent{
  final ExpenseEntity expenseEntity;

  MainEventNewBill({this.expenseEntity});
}

