import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:expense_repository/expense_repository.dart';
import 'package:meta/meta.dart';

part 'main_event.dart';
part 'main_state.dart';
// TODO add credit input
// TODO make list based on credit debit type
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
      List<ExpenseEntity> list = await _expenseRepository.getList(event.month);
      yield MainLoaded(entities: list , month: event.month);
    }
    if(event is MainEventNewBill && state is MainLoaded){
      MainLoaded currentState = state;
      currentState.entities.add(event.expenseEntity);
      yield currentState.copyWith(list: currentState.entities);
    }
  }
}
