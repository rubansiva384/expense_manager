part of 'add_expense_bloc.dart';

class AddExpenseState {
  final String description;
  final String amount;
  final int categoryId;
  final int time;

  AddExpenseState({ this.description , this.amount , this.categoryId , this.time});

  AddExpenseState copyWith({String name , String description , String amount , ExpenseCategory category , int categoryId , int time }){
    return AddExpenseState(
      description:  description ?? this.description,
      amount: amount ?? this.amount,
      categoryId: categoryId ?? this.categoryId ,
      time: time ?? this.time
    );
  }



}


