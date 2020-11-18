import 'package:expense_manager/add_expense/view/add_event_page.dart';
import 'package:expense_repository/expense_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'main_view.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: [
          ActionAdd(
            text: "Credit",
            callback: () {},
          ),
          ActionAdd(
            text: "Debit",
            callback: () {
              final repo = RepositoryProvider.of<ExpenseRepository>(context);
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => AddBillPage(expenseRepository: repo,)));
            },
          )
        ],
      ),
      body: MainView(),
    );
  }
}

class ActionAdd extends StatelessWidget {
  final String text;
  final VoidCallback callback;

  ActionAdd({this.text, this.callback});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: Center(
            child: GestureDetector(
          child: Text("$text"),
          onTap: callback,
        )),
      ),
    );
  }
}
