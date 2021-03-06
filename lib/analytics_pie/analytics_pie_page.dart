import 'package:expense_manager/analytics_pie/analytics_pie_view.dart';
import 'package:expense_manager/analytics_pie/bloc/analytics_pie_bloc.dart';
import 'package:expense_manager/util/Utility.dart';
import 'package:expense_repository/expense_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AnalyticsPieChartPage extends StatelessWidget {
  final ExpenseRepository expenseRepository;
  final DateTime month;

  AnalyticsPieChartPage({this.expenseRepository , this.month});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (_) => AnalyticsPieBloc(startTime: Utility.getInstance().getTimeInstance(), endTime: Utility.getInstance().getTimeInstance(), repository: ExpenseRepository()),
      child: AnalyticsChartView(),
    );
  }
}
