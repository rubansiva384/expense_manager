import 'dart:async';

import 'package:expense_repository/src/database/database.dart';
import 'package:expense_repository/src/expense_event.dart';

import 'model/AnalyticsEntity.dart';
import 'model/ExpenseEntity.dart';

class ExpenseRepository{
final _controller = StreamController<ExpenseRepositoryEvent>();

  Future<List<ExpenseEntity>> getList(int month) async{
      return await MyDatabase.getInstance().getAllExpensesByMonth(month);
  }

  Future<List<AnalyticsEntity>> getAnalytics(DateTime month) async{
      return await MyDatabase.getInstance().getAnalytics(month.month);
  }

  Future<List<AnalyticsEntity>> getAnalyticsByDate(DateTime dateTime) async{
    return await MyDatabase.getInstance().getAnalyticsByDate(dateTime);
  }

  Future<List<AnalyticsEntity>> getAnalyticsByWeek(DateTime startTime , DateTime endTime) async{
    return await MyDatabase.getInstance().getAnalyticsByWeek(startTime , endTime);
  }

  Stream<ExpenseRepositoryEvent> get controller{
    return _controller.stream;
  }

  Future<List<Map<String, dynamic>>> getInOut(int month) async{
    return await MyDatabase.getInstance().getIncome(month);
  }

  addExpense(ExpenseEntity expenseEntity) async{
    int result = await MyDatabase.getInstance().addExpense(expenseEntity);
    if(result != -1)
    _controller.add(ExpenseAdded(expenseEntity: expenseEntity));
  }

  void dispose() => _controller.close();


}