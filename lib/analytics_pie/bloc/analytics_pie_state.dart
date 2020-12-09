
part of 'analytics_pie_bloc.dart';

@immutable
abstract class AnalyticsPieState {

}

class AnalyticsPieInitial extends AnalyticsPieState {

}

class AnalyticsStateLoaded extends AnalyticsPieState{
  final List<AnalyticsEntity> entities;
  final int currentMonth;

  AnalyticsStateLoaded({this.entities , this.currentMonth});

  AnalyticsStateLoaded copyWith({List<ExpenseEntity> entities , int currentMonthPosition}){
    return AnalyticsStateLoaded(
      entities: entities ?? this.entities,
        currentMonth: currentMonthPosition ?? this.currentMonth
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
        labelAccessorFn: (AnalyticsEntity row, _) => '${ChooseCategory.CATEGORY_LIST[row.category].name.substring(0, 5)}: ${row.total}',
      )
    ];
  }


}
