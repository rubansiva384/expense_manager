import 'package:expense_manager/charts/daily/bloc/daily_bar_chart_bloc.dart';
import 'package:expense_manager/widgets/center_circular_progree.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class DailyBarChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DailyBarChartBloc , DailyBarChartState>(builder: (context , state){
      if(state is DailyBarChartStateLoaded){
        return Container(
          child: charts.BarChart(
            state.barChartTimeLineData
          ),
        );
      }
      return CenterCircularProgress();
    });
  }
}
