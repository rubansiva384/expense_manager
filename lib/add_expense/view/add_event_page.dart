import 'package:expense_manager/add_expense/bloc/add_expense_bloc.dart';
import 'package:expense_manager/add_expense/view/add_expense_view.dart';
import 'package:expense_repository/expense_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddBillPage extends StatelessWidget {
  final ExpenseRepository expenseRepository;

  AddBillPage({this.expenseRepository});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add a Bill"),
      ),
      body: BlocProvider(
        create: (_) => AddExpenseBloc(expenseRepository: expenseRepository),
        child: AddExpenseView(),
      ),
    );
  }
}
