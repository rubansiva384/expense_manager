import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:expense_repository/expense_repository.dart';
import 'package:meta/meta.dart';

part 'main_event.dart';
part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  final ExpenseRepository _expenseRepository;
  MainBloc(this._expenseRepository) : super(MainInitial());

  @override
  Stream<MainState> mapEventToState(
    MainEvent event,
  ) async* {
    if(event is MainInitial){
      List<ExpenseEntity> list = await _expenseRepository.getList();
      yield MainLoaded(entities: list);
    }
  }
}
