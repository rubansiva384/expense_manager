part of 'main_bloc.dart';

class MainState {

}

class MainInitial extends MainState {

}

class MainLoaded extends MainState{
  final String salary;
  final String spent;
  final String available;
  List<ExpenseEntity> entities;
  MainLoaded({this.available , this.spent , this.salary , this.entities});

}