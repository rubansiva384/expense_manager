part of 'daily_bar_chart_bloc.dart';

@immutable
abstract class DailyBarChartState {}

class DailyBarChartInitial extends DailyBarChartState {}

class DailyBarChartStateLoaded extends DailyBarChartState{
  final List<AnalyticsEntity> entities;
  final DateTime currentTime;
  final DateTime startTime;

  DailyBarChartStateLoaded({this.entities , this.currentTime , this.startTime});

  List<Series<AnalyticsEntity , String>> get barChartTimeLineData{
    return [
      Series<AnalyticsEntity, String>(
        id: 'Sales',
        domainFn: (AnalyticsEntity sales, _) {
          return "${Utility.getInstance().getTime("hh", sales.time * 1000)}";
        },
        measureFn: (AnalyticsEntity sales, _) => sales.total,
        data: entities,
        labelAccessorFn: (AnalyticsEntity row, _) => '${ChooseCategory.CATEGORY_LIST[row.category].name}',
      )
    ];
  }

}
