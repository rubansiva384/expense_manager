import 'package:expense_repository/src/model/ExpenseEntity.dart';

class ExpenseRepositoryEvent{

}

class ExpenseAdded extends ExpenseRepositoryEvent{
  final ExpenseEntity expenseEntity;

  ExpenseAdded({this.expenseEntity});

}