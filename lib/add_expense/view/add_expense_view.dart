import 'package:expense_manager/add_expense/bloc/add_expense_bloc.dart';
import 'package:expense_repository/expense_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddExpenseView extends StatelessWidget {
  TextEditingController _controllerUserName = TextEditingController();
  TextEditingController _controllerDescription = TextEditingController();
  TextEditingController _controllerAmount = TextEditingController();
  TextEditingController _controllerCategory = TextEditingController();
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
            InputBox(label: "CATEGORY *", controller: _controllerCategory,),
            SaveButton((){
              save(context);
            }),
          ],
        ),
      ),
    );
  }

  void save(BuildContext context){
      context.read<AddExpenseBloc>().add(EventAddBill(
        name: _controllerUserName.text,
        description: _controllerDescription.text,
        amount: _controllerAmount.text ,
        category: _controllerCategory.text ,
        type: ExpenseEntity.TYPE_DEBIT
      ));
      Navigator.pop(context);
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

