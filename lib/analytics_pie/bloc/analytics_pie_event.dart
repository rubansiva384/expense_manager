part of 'analytics_pie_bloc.dart';

@immutable
abstract class AnalyticsPieEvent {}

class AnalyticsPieEventLoad extends AnalyticsPieEvent{
  final DateTime currentTime;

  AnalyticsPieEventLoad({this.currentTime});
}

class AnalyticsEventWeek extends AnalyticsPieEvent{

}

class AnalyticsEventDay extends AnalyticsPieEvent{

}

class AnalyticsEventMonth extends AnalyticsPieEvent{

}

