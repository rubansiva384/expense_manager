import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:expense_manager/choose_category/model/ExpenseCategory.dart';
import 'package:expense_repository/expense_repository.dart';
import 'package:meta/meta.dart';

part 'add_expense_event.dart';
part 'add_expense_state.dart';

class AddExpenseBloc extends Bloc<AddExpenseEvent, AddExpenseState> {
  final ExpenseRepository expenseRepository;
  AddExpenseBloc({this.expenseRepository}) : super(AddExpenseState());

  @override
  Stream<AddExpenseState> mapEventToState(
    AddExpenseEvent event,
  ) async* {
    if(event is EventAddBill){
      ExpenseEntity expenseEntity = new ExpenseEntity( description: event.description , amount: int.parse(event.amount) , type: event.type , dateTime: event.time , category: state.categoryId  );
      expenseRepository.addExpense(expenseEntity);
    }
    if(event is AmountChanged){
      yield state.copyWith(amount: event.amount);
    }
    if(event is DescriptionChange){
      yield state.copyWith(description: event.desc);
    }
    if(event is NameChanged){
      yield state.copyWith(name: event.name);
    }
    if(event is CategoryChanged){
      yield state.copyWith(categoryId: event.categoryId);
    }
  }
}
