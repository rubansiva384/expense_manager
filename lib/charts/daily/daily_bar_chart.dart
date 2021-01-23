import 'package:expense_manager/analytics_pie/bloc/analytics_pie_bloc.dart';
import 'package:expense_manager/charts/daily/bloc/daily_bar_chart_bloc.dart';
import 'package:expense_manager/util/Utility.dart';
import 'package:expense_manager/widgets/center_circular_progree.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class DailyBarChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DailyBarChartBloc , DailyBarChartState>(builder: (context , state){
      if(state is DailyBarChartState && state.entities != null ){
        String text;
        if (state.analyticsType == AnalyticsType.WEEK) {
          text = Utility.getInstance()
              .getTime("dd MMMM ", state.startTime.millisecondsSinceEpoch);
          text += "to ";
          text += Utility.getInstance()
              .getTime("dd MMMM", state.endTime.millisecondsSinceEpoch);
        } else {
          text = Utility.getInstance().getTime(
              "EEEE dd,MMMM", state.startTime.millisecondsSinceEpoch);
        }
        return
        // Column(
        //   children: [
        //     Container(
        //       margin: EdgeInsets.only(top: 20.0),
        //       child: Center(
        //         child: Text(
        //           text,
        //           style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
        //         ),
        //       ),
        //     ),
            Container(
              child: charts.BarChart(
                  state.barChartTimeLineData
              ),
            // )
          // ],
        );
      }
      return CenterCircularProgress();
    });
  }
}