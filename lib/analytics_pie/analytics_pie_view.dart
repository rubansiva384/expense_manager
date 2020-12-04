import 'package:expense_manager/analytics_pie/bloc/analytics_pie_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class AnalyticsChartView extends StatefulWidget {
  @override
  _AnalyticsChartViewState createState() => _AnalyticsChartViewState();
}

class _AnalyticsChartViewState extends State<AnalyticsChartView> with SingleTickerProviderStateMixin{
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AnalyticsPieBloc , AnalyticsPieState>(builder: (context , state){
      if(state is AnalyticsStateLoaded){
        return Scaffold(
          appBar: AppBar(
            title: Text("Analytics"),
            bottom: TabBar(
              onTap: (position) {
                print("tapped on $position");
                context.read<AnalyticsPieBloc>().add(AnalyticsPieEventMonthChanged(monthPosition: position));
              },
              isScrollable: true,
              tabs: [
                Tab(text: "January",),
                Tab(text: "February",),
                Tab(text: "March",),
                Tab(text: "April",),
                Tab(text: "May",),
                Tab(text: "June",),
                Tab(text: "July",),
                Tab(text: "August",),
                Tab(text: "September",),
                Tab(text: "October",),
                Tab(text: "November",),
                Tab(text: "December",),
              ],
              controller: TabController(length: 12 , vsync: this ,),
            ),
          ),
          body: charts.PieChart(state.chartData ,
              animate: false,
              defaultRenderer: new charts.ArcRendererConfig(
                  arcWidth: 100,
                  arcRendererDecorators: [new charts.ArcLabelDecorator(
                  )])
          ),
        );
      }
      return CircularProgressIndicator();
    });
  }
}
