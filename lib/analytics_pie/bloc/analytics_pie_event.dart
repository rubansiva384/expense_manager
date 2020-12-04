part of 'analytics_pie_bloc.dart';

@immutable
abstract class AnalyticsPieEvent {}

class AnalyticsPieEventLoad extends AnalyticsPieEvent{

}

class AnalyticsPieEventMonthChanged extends AnalyticsPieEvent{
  final int monthPosition;

  AnalyticsPieEventMonthChanged({this.monthPosition});
}