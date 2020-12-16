import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:expense_manager/add_expense/model/description.dart';
import 'package:expense_manager/choose_category/model/ExpenseCategory.dart';
import 'package:expense_repository/expense_repository.dart';
import 'package:meta/meta.dart';
import 'package:formz/formz.dart';

part 'add_expense_event.dart';
part 'add_expense_state.dart';
// TODO check mandatories are entered
class AddExpenseBloc extends Bloc<AddExpenseEvent, AddExpenseState> {
  final ExpenseRepository expenseRepository;
  AddExpenseBloc({this.expenseRepository}) : super(AddExpenseState(time: DateTime.now().millisecondsSinceEpoch , descriptionBox: DescriptionBox.pure() , amountBox: AmountBox.pure()));

  @override
  Stream<AddExpenseState> mapEventToState(
    AddExpenseEvent event,
  ) async* {
    if(event is EventAddBill && state.status.isValidated){
      ExpenseEntity expenseEntity = new ExpenseEntity( description: event.description , amount: int.parse(event.amount) , type: event.type , dateTime: (state.time / 1000).round() , category: state.categoryId  );
      expenseRepository.addExpense(expenseEntity);
    }else if (event is EventAddBill){
      FormzStatus status = Formz.validate([state.descriptionBox , state.amountBox]);
      yield state.copyWith(status: status);
      print("we are good");
    }
    if(event is AmountChanged){
      yield state.copyWith(amount: event.amount);
    }
    if(event is DescriptionChange){
      final DescriptionBox descriptionBox =  DescriptionBox.dirty(event.desc);
      yield state.copyWith(description: descriptionBox, status: Formz.validate([descriptionBox]));
    }

    if(event is AmountChange){
      final AmountBox amountBox =  AmountBox.dirty(event.desc);
      yield state.copyWith(amountBox: amountBox, status: Formz.validate([amountBox]));
    }
    if(event is NameChanged){
      yield state.copyWith(name: event.name);
    }
    if(event is CategoryChanged){
      yield state.copyWith(categoryId: event.categoryId);
    }
    if(event is TimeChanged){
      print("time changed => ${event.time}");
      yield state.copyWith(time: event.time);
    }

  }
}
