import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:charts_flutter/flutter.dart';
import 'package:expense_manager/choose_category/choose_category.dart';
import 'package:expense_manager/util/Utility.dart';
import 'package:expense_repository/expense_repository.dart';
import 'package:meta/meta.dart';

part 'daily_bar_chart_event.dart';
part 'daily_bar_chart_state.dart';

class DailyBarChartBloc extends Bloc<DailyBarChartEvent, DailyBarChartState> {
  final ExpenseRepository expenseRepository;
  DailyBarChartBloc({this.expenseRepository}) : super(DailyBarChartInitial());

  @override
  Stream<DailyBarChartState> mapEventToState(
    DailyBarChartEvent event,
  ) async* {
    if(event is DailyBarChartEventLoad){
      final data = await expenseRepository.getAnalyticsByDate(event.dateTime);
      yield DailyBarChartStateLoaded(entities: data , currentTime: event.dateTime);
    }
  }

}
