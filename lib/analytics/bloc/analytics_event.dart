part of 'analytics_bloc.dart';

@immutable
abstract class AnalyticsEvent {}

class AnalyticsEventLoad extends AnalyticsEvent{
  final AnalyticsType type;

  AnalyticsEventLoad({this.type});
}

class AnalyticsEventPrevious extends AnalyticsEvent{

}

class AnalyticsEventNext extends AnalyticsEvent{

}