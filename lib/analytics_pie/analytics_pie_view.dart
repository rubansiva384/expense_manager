import 'package:expense_manager/analytics_pie/bloc/analytics_pie_bloc.dart';
import 'package:expense_manager/choose_category/choose_category.dart';
import 'package:expense_manager/choose_category/model/ExpenseCategory.dart';
import 'package:expense_manager/widgets/AppImage.dart';
import 'package:expense_repository/expense_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:charts_flutter/flutter.dart' as charts;

// TODO make the list legend info
class AnalyticsChartView extends StatefulWidget {
  final int month;

  AnalyticsChartView({this.month});

  @override
  _AnalyticsChartViewState createState() => _AnalyticsChartViewState();
}

class _AnalyticsChartViewState extends State<AnalyticsChartView>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final controller =
        TabController(length: 12, vsync: this, initialIndex: widget.month - 1);
    return Scaffold(
      appBar: AppBar(
        title: Text("Analytics"),
        bottom: TabBar(
          onTap: (position) {
            print("tapped on $position");
            context
                .read<AnalyticsPieBloc>()
                .add(AnalyticsPieEventMonthChanged(month: position + 1));
          },
          isScrollable: true,
          tabs: [
            Tab(
              text: "January",
            ),
            Tab(
              text: "February",
            ),
            Tab(
              text: "March",
            ),
            Tab(
              text: "April",
            ),
            Tab(
              text: "May",
            ),
            Tab(
              text: "June",
            ),
            Tab(
              text: "July",
            ),
            Tab(
              text: "August",
            ),
            Tab(
              text: "September",
            ),
            Tab(
              text: "October",
            ),
            Tab(
              text: "November",
            ),
            Tab(
              text: "December",
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
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AnalyticsPieBloc, AnalyticsPieState>(
        builder: (context, state) {
      if (state is AnalyticsStateLoaded) {
        return Column(
          children: [
            Container(
              height: 350,
              margin: EdgeInsets.all(10),
              child: charts.PieChart(state.chartData,
                  animate: false,
                  defaultRenderer: new charts.ArcRendererConfig(
                      arcWidth: 100,
                      arcRendererDecorators: [new charts.ArcLabelDecorator()])),
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  final categoryId = state.entities[index].category;
                  final category = ChooseCategory.CATEGORY_LIST[categoryId];
                  return ListRow(
                    expenseCategory: category,
                    entity: state.entities[index],
                  );
                },
                itemCount: state.entities.length,
              ),
            )
          ],
        );
      }
      return CircularProgressIndicator();
    });
  }
}

class ListRow extends StatelessWidget {
  final AnalyticsEntity entity;
  final ExpenseCategory expenseCategory;

  ListRow({this.entity, this.expenseCategory});

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
