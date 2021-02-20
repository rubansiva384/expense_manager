import 'package:expense_manager/analytics_pie/bloc/analytics_pie_bloc.dart';
import 'package:expense_manager/charts/daily/bloc/daily_bar_chart_bloc.dart';
import 'package:expense_manager/charts/daily/daily_bar_chart.dart';
import 'package:expense_manager/choose_category/choose_category.dart';
import 'package:expense_manager/choose_category/model/ExpenseCategory.dart';
import 'package:expense_manager/widgets/AppImage.dart';
import 'package:expense_repository/expense_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// TODO make the list legend info
class AnalyticsChartView extends StatefulWidget {
  final DateTime startTime;
  final DateTime endTime;
  AnalyticsType analyticsType = AnalyticsType.DAY;

  AnalyticsChartView({this.startTime, this.endTime});

  @override
  _AnalyticsChartViewState createState() => _AnalyticsChartViewState();
}

class _AnalyticsChartViewState extends State<AnalyticsChartView>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final controller = TabController(length: 3, vsync: this);
    return Scaffold(
      appBar: AppBar(
        title: Text("Analytics"),
        bottom: TabBar(
          onTap: (position) {
            print("tapped on $position");
            AnalyticsPieEvent event;
            switch (position) {
              case 0:
                widget.analyticsType = AnalyticsType.DAY;
                event = AnalyticsEventDay();
                break;
              case 1:
                widget.analyticsType = AnalyticsType.WEEK;
                event = AnalyticsEventWeek();
                break;
              default:
                widget.analyticsType = AnalyticsType.MONTH;
                event = AnalyticsEventMonth();
            }
            context.read<AnalyticsPieBloc>().add(event);
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
          controller: controller,
        ),
      ),
      body: AppChart(),
    );
  }
}

class AppChart extends StatelessWidget {

  AppChart();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AnalyticsPieBloc , AnalyticsPieState>(builder: (context, state) {

      return Column(
        children: [
          Container(
            height: 300,
            margin: EdgeInsets.all(10),
            child: DailyBarChart(chartData: state.barChartTimeLineData, startTime: state.startTime.millisecondsSinceEpoch , endTime: state.startTime.millisecondsSinceEpoch, analyticsType: state.type, ),
          ),
          ListScreen()
        ],
      );
    });
  }
}

class ListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AnalyticsPieBloc, AnalyticsPieState>(
        builder: (context, state) {
      if (state.entities != null) {
        return Container(
          child: Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                final categoryId = state.entities[index].category;
                final category = ChooseCategory.CATEGORY_LIST[categoryId];
                return ListRowDaily(
                  expenseCategory: category,
                  entity: state.entities[index],
                );
              },
              itemCount: state.entities.length,
            ),
          ),
        );
      } else
        return CircularProgressIndicator();
    });
  }
}

class ListRowDaily extends StatelessWidget {
  final AnalyticsEntity entity;
  final ExpenseCategory expenseCategory;

  ListRowDaily({this.entity, this.expenseCategory});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.all(10.0),
            child: Circle(expenseCategory.imageResource),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Text(
                      entity.name,
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      expenseCategory.name,
                      style: TextStyle(fontSize: 15),
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            margin: EdgeInsets.only(left: 10),
            padding: EdgeInsets.only(right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  child: Text(
                    entity.visibleAmount,
                    style: TextStyle(
                        // color: entity.type == ExpenseEntity.TYPE_DEBIT
                        //     ? Colors.red
                        //     : Colors.green,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left,
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    entity.visibleTimeHome,
                    style: TextStyle(fontSize: 13),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ListRowGroup extends StatelessWidget {
  final AnalyticsEntity entity;
  final ExpenseCategory expenseCategory;

  ListRowGroup({this.entity, this.expenseCategory});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.all(10.0),
            child: Circle(expenseCategory.imageResource),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Text(
                      expenseCategory.name,
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(top: 3.0),
                      child: Text(
                        "${entity.countOfCategory} Transactions",
                        style: TextStyle(fontSize: 15, color: Colors.black38),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            margin: EdgeInsets.only(left: 10),
            padding: EdgeInsets.only(right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  child: Text("${entity.visibleAmount}",
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 18,
                      )),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Circle extends StatelessWidget {
  final String imageName;

  Circle(this.imageName);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      child: Stack(
        children: [
          Icon(
            Icons.circle,
            color: Colors.blueAccent,
            size: 60,
          ),
          Center(
            child: AppImage(imageName),
          )
        ],
      ),
    );
  }
}
