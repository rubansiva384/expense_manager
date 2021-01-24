import 'package:expense_manager/chart_try/chart_try_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'chart_view.dart';

class ChartPage extends StatefulWidget {
  @override
  _ChartPageState createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> with TickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    final controller = TabController(length: 3, vsync: this);
    return Scaffold(
      appBar: AppBar(
        title: Text("ChartTry"),
        bottom: TabBar(
          onTap: (i) {
            print("tapped $i");
            ChartTryEvent event;
            switch (i) {
              case 0:
                event = ChartTryEventDay();
                break;
              case 1:
                event = ChartTryEventWeek();
                break;
              case 2:
                event = ChartTryEventMonth();
                break;
            }
            context.read<ChartTryBloc>().add(event);
          },
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
          controller: controller,
        ),
      ),
      body:
      ChartView(),
    );
  }

}
