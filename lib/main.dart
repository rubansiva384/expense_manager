import 'package:expense_manager/home/view/home_page.dart';
import 'package:expense_manager/main/bloc/main_bloc.dart';
import 'package:expense_manager/main/view/MainPage.dart';
import 'package:expense_repository/expense_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  final repo = ExpenseRepository();
  runApp(
      // App(userRepository: UserRepository() , authenticationRepository: AuthenticationRepository(),)
      //MainPage(ExpenseRepository())
      MaterialApp(
    home: RepositoryProvider.value(
      value: repo,
      child: BlocProvider(
        create: (_) => MainBloc(repo)..add(MainEventLoad()),
        child: MainPage(),
      ),
    ),
  ));
}
