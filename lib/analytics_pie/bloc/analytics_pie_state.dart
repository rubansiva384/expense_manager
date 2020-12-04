part of 'analytics_pie_bloc.dart';

@immutable
abstract class AnalyticsPieState {

}

class AnalyticsPieInitial extends AnalyticsPieState {

}

class AnalyticsStateLoaded extends AnalyticsPieState{
  final List<ExpenseEntity> entities;
  final int currentMonthPosition;

  AnalyticsStateLoaded({this.entities , this.currentMonthPosition});

  AnalyticsStateLoaded copyWith({List<ExpenseEntity> entities , int currentMonthPosition}){
    return AnalyticsStateLoaded(
      entities: entities ?? this.entities,
      currentMonthPosition: currentMonthPosition ?? this.currentMonthPosition
    );
  }

  List<Series<ExpenseEntity , int>> get chartData{
    return [
      Series<ExpenseEntity, int>(
        id: 'Sales',
        domainFn: (ExpenseEntity sales, _) {
          return sales.dateTime;
        },
        measureFn: (ExpenseEntity sales, _) => sales.amount,
        data: entities,
        // Set a label accessor to control the text of the arc label.
        labelAccessorFn: (ExpenseEntity row, _) => '${row.date}: ${row.amount}',
      )
    ];
  }


}
