import 'package:expense_manager/analytics_pie/bloc/analytics_pie_bloc.dart';
import 'package:expense_manager/util/Utility.dart';
import 'package:test/test.dart';
import 'package:bloc_test/bloc_test.dart';
void main(){
  group("day calculation test" , (){
    AnalyticsPieBloc analyticsPieBloc;
    DateTime time;

    setUp((){
      time = DateTime(2021 , 1 , 1);
      analyticsPieBloc = AnalyticsPieBloc(startTime: time, endTime: time);
    });

    test("first day test" , (){
      expect(analyticsPieBloc.state.startTime.day, 1);
    });

    blocTest("next day test" ,
            build: () => analyticsPieBloc,
            act: (AnalyticsPieBloc bloc) => bloc.add(AnalyticsChartChanged(index: 98)),
      expect: <AnalyticsPieState>[
        AnalyticsPieState(startTime: DateTime(2021 , 1 , 1).add(Duration(days: -1)), endTime: DateTime(2021 , 1 , 1).add(Duration(days: -1)))
      ]
    );

    blocTest("previous day test" ,
            build: () => analyticsPieBloc,
            act: (AnalyticsPieBloc bloc) => bloc.add(AnalyticsChartChanged(index: 99)),
      expect: <AnalyticsPieState>[
        AnalyticsPieState(startTime: DateTime(2021 , 1 , 1) , endTime: DateTime(2021 , 1 , 1))
      ]
    );

    blocTest("last 5th day test" ,
        build: () => analyticsPieBloc,
        act: (AnalyticsPieBloc bloc) => bloc.add(AnalyticsChartChanged(index: 94)),
        expect: <AnalyticsPieState>[
          AnalyticsPieState(startTime: DateTime(2021 , 1 , 1).add(Duration(days: -5)), endTime: DateTime(2021 , 1 , 1).add(Duration(days: -5)))
        ]
    );


    blocTest("last 4th day test" ,
        build: () => analyticsPieBloc,
        act: (AnalyticsPieBloc bloc) => bloc.add(AnalyticsChartChanged(index: 95)),
        expect: <AnalyticsPieState>[
          AnalyticsPieState(startTime: DateTime(2021 , 1 , 1).add(Duration(days: -4)), endTime: DateTime(2021 , 1 , 1).add(Duration(days: -4)))
        ]
    );

  });
}