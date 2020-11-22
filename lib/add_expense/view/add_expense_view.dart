import 'package:expense_manager/add_expense/bloc/add_expense_bloc.dart';
import 'package:expense_manager/choose_category/choose_category.dart';
import 'package:expense_manager/choose_category/model/ExpenseCategory.dart';
import 'package:expense_repository/expense_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

typedef OnCategoryChosen(ExpenseCategory expenseCategory);

class AddExpenseView extends StatelessWidget {
  TextEditingController _controllerUserName = TextEditingController();
  TextEditingController _controllerDescription = TextEditingController();
  TextEditingController _controllerAmount = TextEditingController();
  ExpenseCategory category;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(35),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InputBox(label: "NAME *", controller: _controllerUserName,),
            InputBox(label: "DESCRIPTION", controller: _controllerDescription,),
            InputBox(label: "AMOUNT *", controller: _controllerAmount,),
            CategoryChooser(categoryChosen),
            SaveButton((){
              save(context);
            }),
          ],
        ),
      ),
    );
  }

  void categoryChosen(ExpenseCategory category){
    this.category = category;
  }

  void save(BuildContext context){
      context.read<AddExpenseBloc>().add(EventAddBill(
        name: _controllerUserName.text,
        description: _controllerDescription.text,
        amount: _controllerAmount.text ,
        category: category.name,
        type: ExpenseEntity.TYPE_DEBIT,
        time: DateTime.now().millisecondsSinceEpoch
      ));
      Navigator.pop(context);
  }

}

class CategoryChooser extends StatelessWidget {
  final OnCategoryChosen categoryChosen;

  CategoryChooser(this.categoryChosen);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RaisedButton(
        child: Text("Choose category"),
        onPressed: () async{
          final ExpenseCategory expenseCategory = await Navigator.push(context, MaterialPageRoute(builder: (context) => ChooseCategory()));
          categoryChosen(expenseCategory);
        },
      ),
    );
  }
}


class InputBox extends StatelessWidget{
  final String label;
  final TextEditingController controller;

  InputBox({ this.controller , this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20) ,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          errorText: null,
          labelText: label
        ),
      ),
    );
  }
}

class SaveButton extends StatelessWidget {
  final VoidCallback callback;

  SaveButton(this.callback);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 50),
      child: RaisedButton(
        child: Padding(
          padding: EdgeInsets.only(left: 50, right: 50),
          child: Text("Add Bill"),
        ),
        onPressed: callback,
      ),
    );
  }
}

