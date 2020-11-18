import 'dart:async';

import 'package:expense_repository/src/database/database.dart';
import 'package:expense_repository/src/expense_event.dart';

import 'model/ExpenseEntity.dart';

class ExpenseRepository{
MyDatabase _dataSource;
final _controller = StreamController<ExpenseRepositoryEvent>();

  Future<List<ExpenseEntity>> getList() async{
      return await _dataSource.getAllExpenses();
  }

  Stream<ExpenseRepositoryEvent> get controller{
    return _controller.stream;
  }

  void addExpense(ExpenseEntity expenseEntity) async{
    await _dataSource.addExpense(expenseEntity);
    _controller.add(ExpenseAdded(expenseEntity: expenseEntity));
  }

  void dispose() => _controller.close();


}