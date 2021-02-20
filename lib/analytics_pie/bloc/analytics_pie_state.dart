
part of 'analytics_pie_bloc.dart';

// class AnalyticsStateChanged extends AnalyticsPieState{
//   final List<AnalyticsEntity> entities;
//   final DateTime currentTime;
//
//   AnalyticsStateChanged({this.entities , this.currentTime});
//
//   AnalyticsStateLoaded copyWith({List<ExpenseEntity> entities , int currentMonthPosition}){
//     return AnalyticsStateLoaded(
//         entities: entities ?? this.entities,
//         currentTime: currentMonthPosition ?? this.currentTime
//     );
//   }
//
//   List<Series<AnalyticsEntity , int>> get chartData{
//     return [
//       Series<AnalyticsEntity, int>(
//         id: 'Sales',
//         domainFn: (AnalyticsEntity sales, _) {
//           return sales.category;
//         },
//         measureFn: (AnalyticsEntity sales, _) => sales.total,
//         data: entities,
//         // Set a label accessor to control the text of the arc label.+-
//         labelAccessorFn: (AnalyticsEntity row, _) => '${ChooseCategory.CATEGORY_LIST[row.category].name}',
//       )
//     ];
//   }
//
//   List<Series<AnalyticsEntity , String>> get barChartData{
//     return [
//       Series<AnalyticsEntity, String>(
//         id: 'Sales',
//         domainFn: (AnalyticsEntity sales, _) {
//           return "${ChooseCategory.CATEGORY_LIST[sales.category].name}";
//         },
//         measureFn: (AnalyticsEntity sales, _) => sales.total,
//         data: entities,
//         labelAccessorFn: (AnalyticsEntity row, _) => '${ChooseCategory.CATEGORY_LIST[row.category].name}',
//       )
//     ];
//   }
//
//   List<Series<AnalyticsEntity , String>> get barChartTimeLineData{
//     return [
//       Series<AnalyticsEntity, String>(
//         id: 'Sales',
//         domainFn: (AnalyticsEntity sales, _) {
//           return "${Utility.getInstance().getTime("hh", sales.time * 1000)}";
//         },
//         measureFn: (AnalyticsEntity sales, _) => sales.total,
//         data: entities,
//         labelAccessorFn: (AnalyticsEntity row, _) => '${ChooseCategory.CATEGORY_LIST[row.category].name}',
//       )
//     ];
//   }
//
//
// }

enum AnalyticsType{
  DAY , WEEK, MONTH
}

class AnalyticsPieState extends Equatable{
  final List<AnalyticsEntity> entities;
  final DateTime endTime;
  final AnalyticsType type;
  final DateTime startTime;
  final List<AnalyticsEntity> barDataList;

  AnalyticsPieState({this.entities , this.endTime , this.type , this.startTime , this.barDataList});

  AnalyticsPieState copyWith({List<AnalyticsEntity> entities, List<AnalyticsEntity> barDataList  , int currentMonthPosition , AnalyticsType analyticsType , DateTime startTime , DateTime endTime ,AnalyticsType type}){
    return AnalyticsPieState(
      entities: entities ?? this.entities,
        endTime: endTime ?? this.endTime,
      type: type ?? analyticsType,
      startTime: startTime ?? this.startTime,
      barDataList: barDataList ?? this.barDataList
    );
  }

  List<Series<AnalyticsEntity , int>> get chartData{
    return [
      Series<AnalyticsEntity, int>(
        id: 'Sales',
        domainFn: (AnalyticsEntity sales, _) {
          return sales.category;
        },
        measureFn: (AnalyticsEntity sales, _) => sales.total,
        data: entities,
        // Set a label accessor to control the text of the arc label.+-
        labelAccessorFn: (AnalyticsEntity row, _) => '${ChooseCategory.CATEGORY_LIST[row.category].name}',
      )
    ];
  }

  List<Series<AnalyticsEntity , String>> get barChartData{
    return [
      Series<AnalyticsEntity, String>(
        id: 'Sales',
        domainFn: (AnalyticsEntity sales, _) {
          return "${ChooseCategory.CATEGORY_LIST[sales.category].name}";
        },
        measureFn: (AnalyticsEntity sales, _) => sales.total,
        data: entities,
        labelAccessorFn: (AnalyticsEntity row, _) => '${ChooseCategory.CATEGORY_LIST[row.category].name}',
      )
    ];
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

  @override
  List<Object> get props => [startTime , endTime , entities , type, barDataList];

}
