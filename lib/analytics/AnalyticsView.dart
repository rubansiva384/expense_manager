import 'package:expense_manager/analytics/bloc/analytics_bloc.dart';
import 'package:expense_manager/analytics/views/AnalyticsChartView.dart';
import 'package:expense_manager/analytics/views/AnalyticsListView.dart';
import 'package:expense_manager/analytics/views/TimeIntervalChanger.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class AnalyticsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AnalyticsBloc , AnalyticsState>(builder: (context , state){
      if(!state.loading) {
        if(state.entities != null) {
          return Column(
            children: [
              TimeIntervalChanger() ,
              AnalyticsChartView(chartData : state.barChartTimeLineData),
              AnalyticsListView()
            ],
          );
        }else{
          return Container(
            child: Center(
              child: Text("No records found!"),
            ),
          );
        }
      }else{
        return CircularProgressIndicator();
      }
    });
  }
}