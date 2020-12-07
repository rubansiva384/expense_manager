import 'dart:async';

import 'package:expense_repository/src/database/database.dart';
import 'package:expense_repository/src/expense_event.dart';

import 'model/ExpenseEntity.dart';

class ExpenseRepository{
final _controller = StreamController<ExpenseRepositoryEvent>();

  Future<List<ExpenseEntity>> getList(int month) async{
      return await MyDatabase.getInstance().getAllExpensesByMonth(month);
  }

  Stream<ExpenseRepositoryEvent> get controller{
    return _controller.stream;
  }

  addExpense(ExpenseEntity expenseEntity) async{
    int result = await MyDatabase.getInstance().addExpense(expenseEntity);
    if(result != -1)
    _controller.add(ExpenseAdded(expenseEntity: expenseEntity));
  }

  void dispose() => _controller.close();


}