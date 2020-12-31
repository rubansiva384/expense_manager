part of 'daily_bar_chart_bloc.dart';

@immutable
abstract class DailyBarChartEvent {}

class DailyBarChartEventLoad extends DailyBarChartEvent{
    final DateTime dateTime;

    DailyBarChartEventLoad({this.dateTime});
}

class DailyBarChartEventLoadWeek extends DailyBarChartEvent{
    final DateTime startTime;
    final DateTime endTime;

    DailyBarChartEventLoadWeek(this.startTime , this.endTime);
}
