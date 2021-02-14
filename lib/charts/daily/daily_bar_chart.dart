import 'package:charts_flutter/flutter.dart';
import 'package:expense_manager/analytics_pie/bloc/analytics_pie_bloc.dart';
import 'package:expense_manager/charts/daily/bloc/daily_bar_chart_bloc.dart';
import 'package:expense_manager/util/Utility.dart';
import 'package:expense_manager/widgets/center_circular_progree.dart';
import 'package:expense_repository/expense_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class DailyBarChart extends StatelessWidget {
  final AnalyticsType analyticsType;
  final List<Series<AnalyticsEntity , String>> chartData;
  final int startTime;
  final int endTime;

  DailyBarChart({this.analyticsType , this.chartData , this.startTime , this.endTime});

  @override
  Widget build(BuildContext context) {
        String text;
        if (analyticsType == AnalyticsType.WEEK) {
          text = Utility.getInstance()
              .getTime("dd MMMM ", startTime);
          text += "to ";
          text += Utility.getInstance()
              .getTime("dd MMMM", endTime);
        } else {
          text = Utility.getInstance().getTime(
              "EEEE dd,MMMM", startTime);
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
                  chartData
              ),
            // )
          // ],
        );
      return CenterCircularProgress();
  }
}