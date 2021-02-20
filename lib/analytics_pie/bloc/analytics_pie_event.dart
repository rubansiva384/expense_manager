part of 'analytics_pie_bloc.dart';

@immutable
abstract class AnalyticsPieEvent {}

class AnalyticsPieEventLoad extends AnalyticsPieEvent{
  final DateTime startTime;
  final DateTime endTime;

  AnalyticsPieEventLoad({this.startTime , this.endTime});
}

class AnalyticsChartChanged extends AnalyticsPieEvent{
  final int index;
  AnalyticsChartChanged({this.index});
}

class AnalyticsEventWeek extends AnalyticsPieEvent{

}

class AnalyticsEventDay extends AnalyticsPieEvent{

}

class AnalyticsEventMonth extends AnalyticsPieEvent{

}

