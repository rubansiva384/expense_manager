part of 'analytics_bloc.dart';

class AnalyticsState {
  final List<AnalyticsEntity> entities;
  final DateTime startDay;
  final DateTime endDay;
  final AnalyticsType analyticsType;
  final bool loading;

  AnalyticsState({this.entities , this.startDay , this.endDay , this.analyticsType , this.loading});

  AnalyticsState copyWith({List<AnalyticsEntity> entities , DateTime startDay , DateTime endDay , AnalyticsType analyticsType , bool loading}){
    return AnalyticsState(
      entities : entities ?? this.entities,
      startDay: startDay ?? this.startDay,
      endDay: endDay ?? this.endDay ,
      analyticsType: analyticsType ?? this.analyticsType,
      loading: loading ?? this.loading
    );
  }

  AnalyticsState changeType(AnalyticsType analyticsType){
    AnalyticsState state;
    switch (analyticsType){
      case AnalyticsType.DAY:
        state = copyWith(startDay: endDay);
        break;
      case AnalyticsType.MONTH:
        state = this;
        break;
      case AnalyticsType.WEEK:
        final startDate =endDay;
        final endDate =  endDay.add(Duration(days: -7));
        state = copyWith(startDay: startDate , endDay: endDate);
        break;
    }
    state = state.copyWith(analyticsType: analyticsType);
    return state;
  }
  
  AnalyticsState next(){
    AnalyticsState state;
    switch (analyticsType){
      case AnalyticsType.DAY:
        state = copyWith(startDay: startDay.add(Duration(days: 1)) , endDay: startDay.add(Duration(days: 1)));
        break;
      case AnalyticsType.MONTH:
        final startDate = DateTime( startDay.month != 12 ? startDay.year : startDay.year + 1, startDay.month != 12 ? startDay.month + 1 : 1 , startDay.day );
        final endDate = DateTime( endDay.month != 12 ? endDay.year : endDay.year + 1 , endDay.month != 12 ? endDay.month + 1 : 1, endDay.day );
       state =  copyWith(startDay: startDate , endDay: endDate);
        break;
      case AnalyticsType.WEEK:
        final startDate = endDay;
        final endDate = endDay.add(Duration(days: 7));
        state = copyWith( endDay: endDate , startDay:  startDate);
        break;
    }
    return state;
  }

  AnalyticsState previous(){
    AnalyticsState state;
    switch (analyticsType){
      case AnalyticsType.DAY:
        state = copyWith(startDay: startDay.add(Duration(days: -1)) , endDay: startDay.add(Duration(days: -1)));
        break;
      case AnalyticsType.MONTH:
        final startDate = DateTime( startDay.month != 1 ? startDay.year : startDay.year - 1, startDay.month != 1 ? startDay.month - 1 : 12 , startDay.day );
        final endDate = DateTime( endDay.month != 1 ? endDay.year : endDay.year - 1 , endDay.month != 1 ? endDay.month - 1 : 12 , endDay.day );
       state =  copyWith(startDay: startDate , endDay: endDate);
        break;
      case AnalyticsType.WEEK:
        final startDate =endDay;
        final endDate =  endDay.add(Duration(days: -7));
        state = copyWith(startDay: startDate , endDay: endDate);
        break;
    }
    return state;
  }

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

