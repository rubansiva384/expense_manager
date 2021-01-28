import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:charts_flutter/flutter.dart';
import 'package:expense_manager/choose_category/choose_category.dart';
import 'package:expense_manager/util/Utility.dart';
import 'package:expense_repository/expense_repository.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'analytics_pie_event.dart';
part 'analytics_pie_state.dart';

class AnalyticsPieBloc extends Bloc<AnalyticsPieEvent, AnalyticsPieState> {
  final ExpenseRepository repository;
  final DateTime startTime ;
  final DateTime endTime;

  AnalyticsPieBloc({this.repository , this.startTime , this.endTime}) : super(AnalyticsPieState(startTime: startTime , endTime:  endTime , type: AnalyticsType.DAY));

  @override
  Stream<AnalyticsPieState> mapEventToState(
    AnalyticsPieEvent event,
  ) async* {
    assert(repository != null);

    if(event is AnalyticsPieEventLoad){
      final List<AnalyticsEntity> data  = await repository.getAnalyticsByDate(event.startTime);
      final List<AnalyticsEntity> chartData  = await repository.getAnalyticsByDate(event.startTime);
      yield state.copyWith(entities: data , endTime: event.startTime, startTime: event.startTime , type: AnalyticsType.DAY);
    }

    if(event is AnalyticsEventDay){

    }

    if(event is AnalyticsEventWeek){
      final List<AnalyticsEntity> data  = await repository.getAnalyticsByWeek(DateTime.now() , DateTime.now().add(Duration(days: -7)));
      yield state.copyWith(entities: data , endTime: DateTime.now() , startTime: DateTime.now().add(Duration(days: -7)) , type: AnalyticsType.WEEK);
    }

  }
}
