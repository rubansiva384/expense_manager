part of 'main_bloc.dart';

class MainState {

}

class MainInitial extends MainState {

}

class MainLoaded extends MainState{
  final String salary;
  final String spent;
  final String available;
  final List<ExpenseEntity> entities;
  final DateTime time;
  MainLoaded({this.available , this.spent , this.salary , this.entities , this.time});

  MainLoaded copyWith({List<ExpenseEntity> list , String salary , String spent , String available , DateTime time}){
    return MainLoaded(
      entities: list ?? this.entities,
      salary: salary ?? this.salary,
      spent: spent ?? this.spent,
      available: available ?? this.available,
      time: time ?? this.time
    );
  }

}