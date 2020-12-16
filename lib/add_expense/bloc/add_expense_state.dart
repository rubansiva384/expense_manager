part of 'add_expense_bloc.dart';

class AddExpenseState {
  final DescriptionBox descriptionBox;
  final AmountBox amountBox;
  final String amount;
  final int categoryId;
  final int time;
  final FormzStatus status;

  AddExpenseState({ this.descriptionBox , this.amount , this.categoryId , this.time , this.status , this.amountBox});

  AddExpenseState copyWith({String name , DescriptionBox description , String amount , ExpenseCategory category , int categoryId , int time , FormzStatus status , AmountBox amountBox }){
    return AddExpenseState(
        descriptionBox:  description ?? this.descriptionBox,
      amount: amount ?? this.amount,
      categoryId: categoryId ?? this.categoryId ,
      time: time ?? this.time ,
      status: status ?? this.status,
      amountBox: amountBox ?? this.amountBox
    );
  }



}


