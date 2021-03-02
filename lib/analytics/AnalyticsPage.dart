import 'package:expense_manager/analytics/AnalyticsView.dart';
import 'package:expense_manager/analytics_pie/bloc/analytics_pie_bloc.dart';
import 'package:expense_manager/util/Utility.dart';
import 'package:expense_repository/expense_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/analytics_bloc.dart';
class AnalyticsPage extends StatefulWidget{
 @override
  State<StatefulWidget> createState() {
   return _AnalyticsPage();
  }
}

class _AnalyticsPage extends State<AnalyticsPage>  with TickerProviderStateMixin {
  TabController _tabController;
  final DateTime currentTime = Utility.getInstance().getTimeInstance();
  AnalyticsBloc analyticsBloc;
  @override
  void initState() {
    super.initState();
    analyticsBloc = AnalyticsBloc(ExpenseRepository() ,currentTime , currentTime);
    _tabController = TabController(vsync: this , length: 3 );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Analytics"),
          bottom: TabBar(
            onTap: (position) {
              print("tapped on $position");
             AnalyticsEventLoad eventLoad = new AnalyticsEventLoad();
              switch (position) {
                case 0:
                  eventLoad = new AnalyticsEventLoad(type: AnalyticsType.DAY);
                  break;
                case 1:
                  eventLoad = new AnalyticsEventLoad(type: AnalyticsType.WEEK);
                  break;
                default:
                  eventLoad = new AnalyticsEventLoad(type: AnalyticsType.MONTH);
              }
              analyticsBloc.add(eventLoad);
            },
            isScrollable: true,
            tabs: [
              Tab(
                text: "Day",
              ),
              Tab(
                text: "Week",
              ),
              Tab(
                text: "Month",
              ),
            ],
            controller: _tabController,
          )
      ),
      body: BlocProvider.value(value: analyticsBloc..add(AnalyticsEventLoad(type: AnalyticsType.DAY)) , child: AnalyticsView(),)
    );
  }
}
