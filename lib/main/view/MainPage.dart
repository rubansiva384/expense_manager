import 'package:expense_manager/main/bloc/main_bloc.dart';
import 'package:expense_repository/expense_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'main_view.dart';

class MainPage extends StatelessWidget {
  final ExpenseRepository _expenseRepository;

  MainPage(this._expenseRepository);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (_) => MainBloc(_expenseRepository) , child: MainView(),);
  }
}

