import 'package:charts_flutter/flutter.dart';
import 'package:expense_repository/expense_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class AnalyticsChartView extends StatelessWidget {
  final  List<Series<AnalyticsEntity , String>> chartData;

  AnalyticsChartView({this.chartData});

  Widget build(BuildContext context) {
    return Container(
      height: 250,
      child: charts.BarChart(chartData),
    );
  }
}
