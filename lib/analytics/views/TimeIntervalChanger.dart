import 'package:expense_manager/analytics/bloc/analytics_bloc.dart';
import 'package:expense_manager/analytics_pie/bloc/analytics_pie_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class TimeIntervalChanger extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AnalyticsBloc , AnalyticsState>(builder: (context , state){
      String timeString;
      switch(state.analyticsType){
        case AnalyticsType.DAY:
          timeString = DateFormat("dd, MMM yyyy").format(state.startDay);
          break;
        case AnalyticsType.WEEK:
          timeString = DateFormat("dd, MMM yy").format(state.startDay) + " to " + DateFormat("dd, MMM yy").format(state.endDay) ;
          break;
        case AnalyticsType.MONTH:
          timeString = DateFormat("dd, MMM yyyy").format(state.startDay);
      }
      return Container(
        child: Row(
          children: [
            Expanded(
              child: GestureDetector(
                child: Icon(
                  Icons.arrow_left,
                  size: 35,
                ),
                onTap: () {
                  BlocProvider.of<AnalyticsBloc>(context).add(AnalyticsEventPrevious());
                },
              ),
            ),
            Expanded(
              child: Center(
                  child: Text(timeString,
                    style: TextStyle(fontSize: 20),
                  )),
            ),
            Expanded(
              child: GestureDetector(
                child: Icon(Icons.arrow_right, size: 35),
                onTap: (){
                  BlocProvider.of<AnalyticsBloc>(context).add(AnalyticsEventNext());
                },
              ),
            ),
          ],
        ),
      );
    },);

  }
}
