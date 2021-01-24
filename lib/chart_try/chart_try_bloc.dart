import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'chart_try_event.dart';
part 'chart_try_state.dart';

class ChartTryBloc extends Bloc<ChartTryEvent, ChartTryState> {
  ChartTryBloc() : super(ChartTryState(type: "DAY"));

  @override
  Stream<ChartTryState> mapEventToState(
    ChartTryEvent event,
  ) async* {
    if(event is ChartTryEventDay){
      yield ChartTryState(type: "DAY");
    }if(event is ChartTryEventWeek){
      yield ChartTryState(type: "WEEK");
    }if(event is ChartTryEventMonth){
      yield ChartTryState(type: "MONTH");
    }
  }
}
