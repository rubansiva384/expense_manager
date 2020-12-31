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

  AnalyticsPieBloc({this.repository}) : super(AnalyticsPieInitial());

  @override
  Stream<AnalyticsPieState> mapEventToState(
    AnalyticsPieEvent event,
  ) async* {
    assert(repository != null);

    if(event is AnalyticsPieEventLoad){
      final List<AnalyticsEntity> data  = await repository.getAnalyticsByDate(event.currentTime);
      yield AnalyticsStateLoaded(entities: data , currentTime: event.currentTime);
    }

    if(event is AnalyticsEventDay){

    }

    if(event is AnalyticsEventWeek){
      final List<AnalyticsEntity> data  = await repository.getAnalyticsByWeek(DateTime.now() , DateTime.now().add(Duration(days: -7)));
      yield AnalyticsStateLoaded(entities: data , currentTime: DateTime.now() , startTime: DateTime.now().add(Duration(days: -7)));
    }

  }
}
