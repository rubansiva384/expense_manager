part of 'daily_bar_chart_bloc.dart';

class DailyBarChartState{
  final List<AnalyticsEntity> entities;
  final DateTime endTime;
  final DateTime startTime;
  final AnalyticsType analyticsType;

  DailyBarChartState(this.startTime , this.endTime , {this.entities , this.analyticsType});

  DailyBarChartState copyWith( DateTime startTime , DateTime endTime ,{List<AnalyticsEntity> entities , AnalyticsType analyticsType }){
    return DailyBarChartState(startTime, endTime ,
      entities: entities ?? this.entities ,
      analyticsType:  analyticsType ?? this.analyticsType
    );
  }

  List<Series<AnalyticsEntity , String>> get barChartTimeLineData{
    return [
      Series<AnalyticsEntity, String>(
        id: 'Sales',
        domainFn: (AnalyticsEntity sales, _) {
          String text;
          if(analyticsType == AnalyticsType.DAY)
            text = "${Utility.getInstance().getTime("hh", sales.time * 1000)}";
          else
            text = "${Utility.getInstance().getTime("dd", sales.time * 1000)}";
          return text;
        },
        measureFn: (AnalyticsEntity sales, _) => sales.total,
        data: entities,
        labelAccessorFn: (AnalyticsEntity row, _) => '${ChooseCategory.CATEGORY_LIST[row.category].name}',
      )
    ];
  }

}
