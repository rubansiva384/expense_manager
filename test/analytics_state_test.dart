import 'package:bloc_test/bloc_test.dart';
import 'package:expense_manager/analytics/bloc/analytics_bloc.dart';
import 'package:expense_manager/analytics_pie/bloc/analytics_pie_bloc.dart';
import 'package:expense_manager/util/Utility.dart';
import 'package:expense_repository/expense_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){
  group("analytics bloc test" , (){
    AnalyticsBloc analyticsBloc;
    DateTime time;

    setUp((){
      time = DateTime(2021 , 1 , 1);
      analyticsBloc = AnalyticsBloc(ExpenseRepository(), time , time );
    });

    test("bloc initialization test", (){
      expect(analyticsBloc.state.startDay.day, 1);
    });

    test("next operation test" , (){
      AnalyticsState analyticsState = AnalyticsState(startDay: time , endDay:  time , analyticsType: AnalyticsType.DAY);
      analyticsState = analyticsState.next();
      expect(DateTime(2021 , 1 , 2), analyticsState.startDay);
      expect(DateTime(2021 , 1 , 2), analyticsState.endDay);

      analyticsState = analyticsState.copyWith(analyticsType: AnalyticsType.WEEK);
      analyticsState = analyticsState.next();
      expect(DateTime(2021 , 1 , 2), analyticsState.startDay);
      expect(DateTime(2021 , 1 , 9), analyticsState.endDay);

      analyticsState = analyticsState.next();
      expect(DateTime(2021 , 1 , 9), analyticsState.startDay);
      expect(DateTime(2021 , 1 , 16), analyticsState.endDay);

      analyticsState = analyticsState.copyWith(analyticsType: AnalyticsType.MONTH);
      analyticsState = analyticsState.next();
      expect(DateTime(2021 , 2 , 9), analyticsState.startDay);
      expect(DateTime(2021 , 2, 16), analyticsState.endDay);

      analyticsState = analyticsState.next();
      expect(DateTime(2021 , 3, 9), analyticsState.startDay);
      expect(DateTime(2021 , 3, 16), analyticsState.endDay);

      time = DateTime(2021 , 12 , 30);
      analyticsState = AnalyticsState(startDay: time , endDay:  time , analyticsType: AnalyticsType.MONTH);
      analyticsState = analyticsState.next();
      expect(DateTime(2022 , 1, 30), analyticsState.startDay);
      expect(DateTime(2022, 1, 30), analyticsState.endDay);

    });

    test("previous operation test" , (){
      time = DateTime(2021 , 10 , 2);
      AnalyticsState analyticsState = AnalyticsState(startDay: time , endDay:  time , analyticsType: AnalyticsType.DAY);
      analyticsState = analyticsState.previous();
      expect(DateTime(2021 , 10 , 1), analyticsState.startDay);
      expect(DateTime(2021 , 10 , 1), analyticsState.endDay);

      analyticsState = analyticsState.copyWith(analyticsType: AnalyticsType.WEEK);
      analyticsState = analyticsState.previous();
      expect(DateTime(2021 , 10 , 1), analyticsState.startDay);
      expect(DateTime(2021 , 9 , 24), analyticsState.endDay);

      analyticsState = analyticsState.previous();
      expect(DateTime(2021 , 9 , 24), analyticsState.startDay);
      expect(DateTime(2021 , 9 , 17), analyticsState.endDay);

      analyticsState = analyticsState.copyWith(analyticsType: AnalyticsType.MONTH);
      analyticsState = analyticsState.previous();
      expect(DateTime(2021 , 8 , 24), analyticsState.startDay);
      expect(DateTime(2021 , 8, 17), analyticsState.endDay);

      analyticsState = analyticsState.previous();
      expect(DateTime(2021 , 7, 24), analyticsState.startDay);
      expect(DateTime(2021 , 7, 17), analyticsState.endDay);

      time = DateTime(2021 , 1 , 30);
      analyticsState = AnalyticsState(startDay: time , endDay:  time , analyticsType: AnalyticsType.MONTH);
      analyticsState = analyticsState.previous();
      expect(DateTime(2020 , 12, 30), analyticsState.startDay);
      expect(DateTime(2020, 12, 30), analyticsState.endDay);
    });

    test("change type test" , (){
      time = DateTime(2021 , 10 , 30);

      AnalyticsState state = AnalyticsState(startDay: time , endDay:  time ,analyticsType: AnalyticsType.DAY);
      state = state.changeType(AnalyticsType.WEEK);
      expect(state.analyticsType, AnalyticsType.WEEK);
      expect(DateTime(2021 , 10 , 30), state.startDay);
      expect(DateTime(2021 , 10 , 23), state.endDay);

      state = state.changeType(AnalyticsType.DAY);
      expect(state.analyticsType, AnalyticsType.DAY);
      expect(DateTime(2021 , 10 , 23), state.startDay);
      expect(DateTime(2021 , 10 , 23), state.endDay);


      state = state.changeType(AnalyticsType.MONTH);
      expect(state.analyticsType, AnalyticsType.MONTH);
      expect(DateTime(2021 , 10 , 23) , state.startDay);
      expect(DateTime(2021 , 10 , 23) , state.endDay);

      state = state.changeType(AnalyticsType.WEEK);
      expect(state.analyticsType, AnalyticsType.WEEK);
      expect(DateTime(2021 , 10 , 23), state.startDay);
      expect(DateTime(2021 , 10 , 16), state.endDay);

    });


  });
}