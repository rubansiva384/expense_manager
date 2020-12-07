part of 'analytics_pie_bloc.dart';

@immutable
abstract class AnalyticsPieEvent {}

class AnalyticsPieEventLoad extends AnalyticsPieEvent{
  final int month;

  AnalyticsPieEventLoad({this.month});
}

class AnalyticsPieEventMonthChanged extends AnalyticsPieEvent{
  final int month;

  AnalyticsPieEventMonthChanged({this.month});
}