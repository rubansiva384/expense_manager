import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:charts_flutter/flutter.dart';
import 'package:expense_manager/analytics_pie/bloc/analytics_pie_bloc.dart';
import 'package:expense_manager/choose_category/choose_category.dart';
import 'package:expense_manager/util/Utility.dart';
import 'package:expense_repository/expense_repository.dart';
import 'package:meta/meta.dart';

part 'daily_bar_chart_event.dart';
part 'daily_bar_chart_state.dart';

class DailyBarChartBloc extends Bloc<DailyBarChartEvent, DailyBarChartState> {
  final ExpenseRepository expenseRepository;
  final AnalyticsPieBloc analyticsPieBloc;
  StreamSubscription streamSubscription;
  AnalyticsPieState oldAnalyticsState;
  final DateTime startTime;
  final DateTime endTime;
  DailyBarChartBloc({this.expenseRepository , this.analyticsPieBloc , this.startTime , this.endTime}) : super(DailyBarChartState(startTime , endTime));

  @override
  Stream<DailyBarChartState> mapEventToState(
    DailyBarChartEvent event,
  ) async* {
    if(event is DailyBarChartEventLoad){
      List<AnalyticsEntity> list;
      if(event.analyticsType == AnalyticsType.DAY) {
        list = await expenseRepository.getAnalyticsByDate(event.startTime);
      }else{
        list = await expenseRepository.getAnalyticsByWeek(event.startTime , event.endTime );
      }
      yield state.copyWith( event.startTime , event.endTime , entities: list  , analyticsType: event.analyticsType );
    }
  }

  @override
  Future<void> close() {
    streamSubscription?.cancel();
    return super.close();
  }

}
