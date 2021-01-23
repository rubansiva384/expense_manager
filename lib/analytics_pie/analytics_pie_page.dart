import 'package:expense_manager/analytics_pie/analytics_pie_view.dart';
import 'package:expense_repository/expense_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AnalyticsPieChartPage extends StatelessWidget {
  final ExpenseRepository expenseRepository;
  final DateTime month;

  AnalyticsPieChartPage({this.expenseRepository , this.month});

  @override
  Widget build(BuildContext context) {
    return  AnalyticsChartView(startTime: month, endTime: month,);
  }
}
