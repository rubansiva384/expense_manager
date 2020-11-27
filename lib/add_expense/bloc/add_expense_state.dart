part of 'add_expense_bloc.dart';

class AddExpenseState {
  final String name;
  final String description;
  final String amount;
  final ExpenseCategory expenseCategory;

  AddExpenseState({this.name , this.description , this.amount , this.expenseCategory});

  AddExpenseState copyWith({String name , String description , String amount , ExpenseCategory category}){
    return AddExpenseState(
      name:  name ?? this.name,
      description:  description ?? this.description,
      amount: amount ?? this.amount,
      expenseCategory: category ?? this.expenseCategory
    );
  }
}


