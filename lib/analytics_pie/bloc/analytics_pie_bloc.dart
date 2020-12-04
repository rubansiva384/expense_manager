import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:charts_flutter/flutter.dart';
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
      final data = await repository.getList();
      yield AnalyticsStateLoaded(entities: data , currentMonthPosition: 0);
    }

    if(event is AnalyticsPieEventMonthChanged && state is AnalyticsStateLoaded){
      final data = await repository.getList();
    }

  }
}