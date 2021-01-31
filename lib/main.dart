import 'package:expense_manager/chart_try/chart_page.dart';
import 'package:expense_manager/chart_try/chart_try_bloc.dart';
import 'package:expense_manager/main/bloc/main_bloc.dart';
import 'package:expense_manager/main/view/MainPage.dart';
import 'package:expense_repository/expense_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  Bloc.observer = MyObserver();
  final repo = ExpenseRepository();
  final thisMonth = DateTime.now();
  runApp(
      // App(userRepository: UserRepository() , authenticationRepository: AuthenticationRepository(),)
      //MainPage(ExpenseRepository())
//    ScrollApp()
      MaterialApp(
    home:
    BlocProvider(
      create: (_) => ChartTryBloc(),
      child: ChartPage(),
    )
   // RepositoryProvider.value(
   //   value: repo,
   //   child: BlocProvider(
   //     create: (_) => MainBloc(repo)..add(MainEventLoad(time: thisMonth)),
   //     child: MainPage(),
   //   ),
   // ),
  ));
}

class MyObserver extends BlocObserver {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    print(transition);
    super.onTransition(bloc, transition);
  }
}
