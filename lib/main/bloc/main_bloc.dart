import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:expense_repository/expense_repository.dart';
import 'package:meta/meta.dart';

part 'main_event.dart';
part 'main_state.dart';
// TODO set income spent based on database
class MainBloc extends Bloc<MainEvent, MainState> {
  final ExpenseRepository _expenseRepository;
  MainBloc(this._expenseRepository) : super(MainInitial()){
    _expenseRepository.controller.listen((event) {
      if(event is ExpenseAdded){
        add(MainEventNewBill(expenseEntity : event.expenseEntity));
      }
    });
  }

  @override
  Stream<MainState> mapEventToState(
    MainEvent event,
  ) async* {
    if(event is MainEventLoad){
      List<ExpenseEntity> list = await _expenseRepository.getList(event.time.month);
      MainLoaded mainEvent = MainLoaded(entities: list , time: event.time);
      List<Map<String , dynamic>> maps = await _expenseRepository.getInOut(event.time.month);
      int available = 0;
      if(maps.length > 0){
        int income = 0;
        int spent = 0;
        if(maps[0][MyDatabase.COLUMN_EXPENSE_TYPE] == ExpenseEntity.TYPE_DEBIT ){
          spent = maps[0][MyDatabase.COLUMN_ANALYTICS_TOTAL];
          mainEvent = mainEvent.copyWith(spent: spent.toString());
        }else{
          income = maps[0][MyDatabase.COLUMN_ANALYTICS_TOTAL];
          mainEvent = mainEvent.copyWith(salary: income.toString());
        }
        if(maps.length > 1){
          if(maps[1][MyDatabase.COLUMN_EXPENSE_TYPE] == ExpenseEntity.TYPE_DEBIT ){
            spent = maps[1][MyDatabase.COLUMN_ANALYTICS_TOTAL];
            mainEvent = mainEvent.copyWith(spent: spent.toString());
          }else{
            income = maps[1][MyDatabase.COLUMN_ANALYTICS_TOTAL];
            mainEvent = mainEvent.copyWith(salary: income.toString());
          }
        }
        available = income - spent;
      }
      mainEvent = mainEvent.copyWith(available: available.toString());
      yield mainEvent;
    }
    if(event is MainEventNewBill && state is MainLoaded){
      MainLoaded currentState = state;
      currentState.entities.add(event.expenseEntity);
      yield currentState.copyWith(list: currentState.entities);
    }
  }
}
