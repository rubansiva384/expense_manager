import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:charts_flutter/flutter.dart';
import 'package:expense_manager/choose_category/choose_category.dart';
import 'package:expense_manager/util/Utility.dart';
import 'package:expense_repository/expense_repository.dart';
import 'package:meta/meta.dart';

part 'analytics_event.dart';
part 'analytics_state.dart';

class AnalyticsBloc extends Bloc<AnalyticsEvent, AnalyticsState> {
  final ExpenseRepository expenseRepository;
  AnalyticsBloc({this.expenseRepository}) : super(AnalyticsState());

  @override
  Stream<AnalyticsState> mapEventToState(
    AnalyticsEvent event,
  ) async* {
    if(event is AnalyticsEventLoad){
      final List<AnalyticsEntity> data  = await expenseRepository.getAnalyticsByDate(state.startDay);
      final List<AnalyticsEntity> chartData  = await expenseRepository.getAnalyticsByDate(state.endDay);
      yield state.copyWith(entities: data , endTime: event.startTime, startTime: event.startTime , type: AnalyticsType.DAY);
    }
  }
}
