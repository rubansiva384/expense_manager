import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:expense_repository/expense_repository.dart';
import 'package:meta/meta.dart';

part 'add_expense_event.dart';
part 'add_expense_state.dart';

class AddExpenseBloc extends Bloc<AddExpenseEvent, AddExpenseState> {
  final ExpenseRepository expenseRepository;
  AddExpenseBloc({this.expenseRepository}) : super(AddExpenseInitial());

  @override
  Stream<AddExpenseState> mapEventToState(
    AddExpenseEvent event,
  ) async* {
    if(event is EventAddBill){
      ExpenseEntity expenseEntity = new ExpenseEntity(name: event.name , description: event.description , amount: 100 , type: event.type  );
      expenseRepository.addExpense(expenseEntity);
    }
  }
}
