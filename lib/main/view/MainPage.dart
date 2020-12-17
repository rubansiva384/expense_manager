import 'package:expense_manager/add_expense/view/add_event_page.dart';
import 'package:expense_manager/choose_category/model/ExpenseCategory.dart';
import 'package:expense_repository/expense_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'main_view.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final repo = RepositoryProvider.of<ExpenseRepository>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: [
          ActionAdd(
            text: "Credit",
            callback: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => AddBillPage(expenseRepository: repo , type: ExpenseEntity.TYPE_CREDIT,)));
            },
          ),
          ActionAdd(
            text: "Debit",
            callback: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => AddBillPage(expenseRepository: repo,type: ExpenseEntity.TYPE_DEBIT,)));
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
          child: Center(
            child: FlatButton(child:  Text("$text" , style: TextStyle(color: Colors.white),), onPressed: callback,),
          ),
      );
  }
}
