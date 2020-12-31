import 'package:expense_repository/expense_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class DailyAnalysisCumulative extends StatelessWidget {
  final List<charts.Series<AnalyticsEntity, String>> chartData;

  const DailyAnalysisCumulative({Key key, this.chartData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: charts.BarChart(chartData,
          animate: false,
    ));
  }

}
