part of 'daily_bar_chart_bloc.dart';

@immutable
class DailyBarChartEvent {
DailyBarChartEvent();
}

class DailyBarChartEventLoad extends DailyBarChartEvent{
    final DateTime startTime;
    final DateTime endTime;
    DailyBarChartEventLoad({this.startTime , this.endTime});
}

// //TODO remove the type here; if the method name Week you already have the type
// class DailyBarChartEventLoadWeek extends DailyBarChartEvent{
//     final DateTime startTime;
//     final DateTime endTime;
//     final AnalyticsType type;
//
//     DailyBarChartEventLoadWeek({this.startTime , this.endTime , this.type}) : super(type: type);
// }
