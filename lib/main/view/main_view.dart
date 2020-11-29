import 'package:expense_manager/add_expense/view/add_expense_view.dart';
import 'package:expense_manager/choose_category/choose_category.dart';
import 'package:expense_manager/main/bloc/main_bloc.dart';
import 'package:expense_manager/widgets/AppImage.dart';
import 'package:expense_repository/expense_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
            DashBoarHeader(),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, int) {
                  ExpenseEntity entity = state.entities[int];
                  return ListRow(
                    entity: entity,
                  );
                },
                itemCount: state.entities.length,
              ),
            ),
          ],
        ));
      }
    });
  }
}

class ListRow extends StatelessWidget {
  final ExpenseEntity entity;

  ListRow({this.entity});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.all(10.0),
            child: Circle(entity.image),
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
                      entity.description,
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
                        color: Colors.red,
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
    print("image is $imageName");
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
  final TextStyle styleBold = TextStyle(
      fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20.0);
  final TextStyle styleNormal = TextStyle(color: Colors.white);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.blue),
      padding: EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "Apr , 2020",
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Image(
                  height: 25,
                  width: 25,
                  image: AssetImage(ChooseCategory.PACKAGE_NAME +
                      "baseline_leaderboard_white_36dp.png"),
                ),
              ),
            ],
          ),
          Container(
              height: 170,
              margin: EdgeInsets.only(top: 20, bottom: 20),
              padding: EdgeInsets.all(20.0),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white10,
                  border: Border.all(color: Colors.white, width: 0.3),
                  borderRadius: BorderRadius.all(Radius.circular(5.0))),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Container(
                              width: 30,
                              height: 30,
                              child: Image(
                                image: AssetImage(ChooseCategory.PACKAGE_NAME +
                                    "baseline_account_balance_wallet_white_36dp.png"),
                              ),
                            ),
                          ),
                          Text(
                            "Available balance",
                            style: styleNormal,
                          ),
                          Text(
                            "\$ 4,500",
                            style: styleBold,
                          ),
                        ],
                      ),
                    ),
                  ),
                  VerticalDivider(
                    color: Colors.black,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Text(
                                  "Salary : ",
                                  style: styleNormal,
                                ),
                              ),
                              Expanded(
                                flex: 7,
                                child: Text(
                                  "\$ 50,000",
                                  style: styleBold,
                                ),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Text(
                                  "Spent : ",
                                  style: styleNormal,
                                ),
                              ),
                              Expanded(
                                flex: 7,
                                child: Text("\$ 50,000", style: styleBold),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
