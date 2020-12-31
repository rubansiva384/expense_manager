import 'package:expense_manager/analytics_pie/analytics_pie_page.dart';
import 'package:expense_manager/choose_category/choose_category.dart';
import 'package:expense_manager/choose_category/model/ExpenseCategory.dart';
import 'package:expense_manager/main/bloc/main_bloc.dart';
import 'package:expense_manager/widgets/AppImage.dart';
import 'package:expense_repository/expense_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class MainView extends StatelessWidget {
  Widget build(BuildContext context) {
    // ignore: missing_return
    return BlocBuilder<MainBloc, MainState>(builder: (context, state) {
      if (state is MainInitial) {
        return Container(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      } else if (state is MainLoaded) {
        return Container(
            child: Column(
          children: [
            DashBoarHeader(state.time),
            Expanded(
              child: state.entities.isNotEmpty
                  ? ListView.builder(
                      itemBuilder: (context, int) {
                        ExpenseEntity entity = state.entities[int];
                        ExpenseCategory category =
                            entity.type == ExpenseEntity.TYPE_DEBIT
                                ? ChooseCategory.CATEGORY_LIST[entity.category]
                                : ChooseCategory.INCOME_LIST[entity.category];
                        return ListRow(
                          entity: entity,
                          expenseCategory: category,
                        );
                      },
                      itemCount: state.entities.length,
                    )
                  : EmptyList(),
            ),
          ],
        ));
      }
    });
  }
}

class EmptyList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "No Transactions Available! \n Please do a Debit or Credit transaction to start.",
        style: TextStyle(color: Colors.red, fontSize: 15.0),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class ListRow extends StatelessWidget {
  final ExpenseEntity entity;
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
                      entity.description,
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
                        color: entity.type == ExpenseEntity.TYPE_DEBIT
                            ? Colors.red
                            : Colors.green,
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

class DashBoarHeader extends StatelessWidget {
  final TextStyle styleBold =
      TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 18);
  final TextStyle styleNormal = TextStyle(color: Colors.white, fontSize: 12);
  final double borderWidth = 0.3;
  final Color borderColor = Colors.white;
  final DateTime month;

  DashBoarHeader(this.month);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainBloc, MainState>(builder: (context, state) {
      if (state is MainLoaded) {
        return Container(
          decoration: BoxDecoration(color: Colors.blue),
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Row(
              children: [
                FlatButton(
                  child: Text(
                    DateFormat("MMM , yyyy").format(month),
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                  onPressed: () async {
                    final date = await showDatePicker(context: context , initialDate: DateTime.now() , firstDate: DateTime(2000), lastDate: DateTime.now());
                    context.read<MainBloc>().add(MainEventLoad(time: date));
                  },
                )
            ],
          ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        final repo =
                            RepositoryProvider.of<ExpenseRepository>(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AnalyticsPieChartPage(
                                      expenseRepository: repo,
                                      month: month,
                                    )));
                      },
                      child: Image(
                        height: 25,
                        width: 25,
                        image: AssetImage(ChooseCategory.PACKAGE_NAME +
                            "baseline_leaderboard_white_36dp.png"),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                  height: 160,
                  width: double.infinity,
                  margin: EdgeInsets.only(top: 20, bottom: 20),
                  decoration: BoxDecoration(
                      color: Colors.white10,
                      border:
                          Border.all(color: borderColor, width: borderWidth),
                      borderRadius: BorderRadius.all(Radius.circular(5.0))),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Container(
                                  width: 30,
                                  height: 30,
                                  child: Image(
                                    image: AssetImage(ChooseCategory
                                            .PACKAGE_NAME +
                                        "baseline_account_balance_wallet_white_36dp.png"),
                                  ),
                                ),
                              ),
                              Text(
                                "Available balance",
                                style: styleNormal,
                              ),
                              Text(
                                "\$ ${state.available}",
                                style: styleBold,
                              ),
                            ],
                          ),
                        ),
                      ),
                      VerticalDivider(
                        width: borderWidth,
                        color: borderColor,
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 4,
                                      child: Text(
                                        "Income : ",
                                        style: styleNormal,
                                      ),
                                    ),
                                    Expanded(
                                      flex: 6,
                                      child: Text(
                                        "\$ ${state.salary ?? 0}",
                                        style: styleBold,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Expanded(
                                      flex: 4,
                                      child: Text(
                                        "Spent : ",
                                        style: styleNormal,
                                      ),
                                    ),
                                    Expanded(
                                      flex: 6,
                                      child: Text("\$ ${state.spent ?? 0}",
                                          style: styleBold),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ))
            ],
          ),
        );
      }

      return CircularProgressIndicator();
    });
  }
}
