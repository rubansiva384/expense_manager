import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:charts_flutter/flutter.dart';
import 'package:expense_manager/analytics_pie/bloc/analytics_pie_bloc.dart';
import 'package:expense_manager/choose_category/choose_category.dart';
import 'package:expense_manager/util/Utility.dart';
import 'package:expense_repository/expense_repository.dart';
import 'package:meta/meta.dart';

part 'analytics_event.dart';
part 'analytics_state.dart';

class AnalyticsBloc extends Bloc<AnalyticsEvent, AnalyticsState> {
  final ExpenseRepository expenseRepository;
  AnalyticsBloc(this.expenseRepository , DateTime startDay, DateTime endDay) : super(AnalyticsState(startDay: startDay , endDay: endDay , loading: true));

  @override
  Stream<AnalyticsState> mapEventToState(
    AnalyticsEvent event,
  ) async* {
    if(event is AnalyticsEventLoad && event.type == AnalyticsType.DAY){
      final List<AnalyticsEntity> data  = await expenseRepository.getAnalyticsByDate(state.endDay);
      yield state.copyWith(entities: data , analyticsType: event.type , loading: false , startDay: state.endDay , endDay: state.endDay);
    }else if (event is AnalyticsEventPrevious){
      yield state.copyWith(startDay: state.startDay.add(Duration(days: -1)) , endDay: state.startDay.add(Duration(days: -1)));
      add(AnalyticsEventLoad(type: state.analyticsType));
    }else if (event is AnalyticsEventNext){
      final tempState =  state.next();
      add(AnalyticsEventLoad(type: state.analyticsType));
    }else if(event is AnalyticsEventLoad && event.type == AnalyticsType.WEEK){
      // yield state.copyWith(loading: true);
      final startTime = state.endDay.add(Duration(days: -7));
      final endTime = state.startDay;
      final List<AnalyticsEntity> data  = await expenseRepository.getAnalyticsByWeek(startTime , endTime);
      // final List<AnalyticsEntity> chartData  = await expenseRepository.getAnalyticsByDate(state.endDay);
      yield state.copyWith(entities: data , analyticsType: event.type , loading: false , startDay: startTime , endDay : endTime);
    }else if(event is AnalyticsEventLoad && event.type == AnalyticsType.MONTH){
      final List<AnalyticsEntity> data  = await expenseRepository.getAnalyticsByMonth(state.endDay);
      // final List<AnalyticsEntity> chartData  = await expenseRepository.getAnalyticsByDate(state.endDay);
      yield state.copyWith(entities: data , analyticsType: event.type , loading: false);
    }
  }

  // Stream<AnalyticsState> mapDaysWithEvent(AnalyticsEventLoad event) async*{
  //   final List<AnalyticsEntity> data  = await expenseRepository.getAnalyticsByDate(state.startDay);
  //   // final List<AnalyticsEntity> chartData  = await expenseRepository.getAnalyticsByDate(state.endDay);
  //   yield state.copyWith(entities: data , analyticsType: event.type , loading: false);
  // }

}
