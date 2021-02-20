part of 'analytics_bloc.dart';

class AnalyticsState {
  final List<AnalyticsEntity> entities;
  final int startDay;
  final int endDay;

  AnalyticsState({this.entities , this.startDay , this.endDay});

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

