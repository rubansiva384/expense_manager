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

  MainLoaded copyWith({List<ExpenseEntity> list , String salary , String spent , String available}){
    return MainLoaded(
      entities: list ?? this.entities,
      salary: salary ?? this.salary,
      spent: spent ?? this.spent,
      available: available ?? this.available
    );
  }

}