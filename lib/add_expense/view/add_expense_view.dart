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
  final BoxDecoration _boxDecoration =
      BoxDecoration(border: Border.all(width: 1.3, color: Colors.black26));

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.black12
      ),
      child: Container(
        margin: EdgeInsets.all(45),
        child: Center(
          child: Container(
            padding: EdgeInsets.all(30.0),
            decoration: BoxDecoration(
                color: Colors.white
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InputBox(
                  label: "NAME *",
                  controller: _controllerUserName,
                  boxDecoration: _boxDecoration,
                ),
                InputBox(
                  label: "DESCRIPTION",
                  controller: _controllerDescription,
                  boxDecoration: _boxDecoration,
                ),
                InputBox(
                  label: "AMOUNT *",
                  controller: _controllerAmount,
                  boxDecoration: _boxDecoration,
                ),
                InputChooseCategory(null, _boxDecoration, categoryChosen),
                SaveButton(() {
                  save(context);
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void categoryChosen(ExpenseCategory category) {
    this.category = category;
  }

  void save(BuildContext context) {
    context.read<AddExpenseBloc>().add(EventAddBill(
        name: _controllerUserName.text,
        description: _controllerDescription.text,
        amount: _controllerAmount.text,
        category: category.name,
        type: ExpenseEntity.TYPE_DEBIT,
        time: DateTime.now().millisecondsSinceEpoch));
    Navigator.pop(context);
  }
}

class InputBox extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final BoxDecoration boxDecoration;

  InputBox({this.controller, this.label, this.boxDecoration});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: EdgeInsets.only(top: 20.0, bottom: 5),
              child: Text(label),
            )),
        Container(
          decoration: boxDecoration,
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.all(5.0),
                errorText: null,
                border: InputBorder.none),
          ),
        )
      ],
    );
  }
}

class InputChooseCategory extends StatelessWidget {
  final ExpenseCategory entity;
  final BoxDecoration _boxDecoration;
  final OnCategoryChosen categoryChosen;

  InputChooseCategory(this.entity, this._boxDecoration, this.categoryChosen);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final ExpenseCategory expenseCategory = await Navigator.push(
            context, MaterialPageRoute(builder: (context) => ChooseCategory()));
        categoryChosen(expenseCategory);
      },
      child: Column(
        children: [
          Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: EdgeInsets.only(top: 10.0, bottom: 5),
                child: Text("CATEGORY *"),
              )),
          Container(
            decoration: _boxDecoration,
            padding: EdgeInsets.all(5),
            child: Row(
              children: [
                Circle(
                  sourceName: entity != null ? entity.imageResource : "",
                ),
                Container(
                  margin: EdgeInsets.only(left: 5),
                  child: Text(
                    entity == null ? "Select a category" : entity.name,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          )
        ],
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
      decoration: BoxDecoration(
          color: hexToColor("#FFB967")
      ),
      margin: EdgeInsets.only(top: 70),
      padding: EdgeInsets.all(10.0),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(child:
            Align(
                child: Text("Add Bill" , style: TextStyle(color: Colors.black),))
            ),
          )
        ],
      ),
    );
  }
}

class Circle extends StatelessWidget {
  final String sourceName;

  Circle({this.sourceName});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Center(
            child: Icon(
              Icons.circle,
              color: hexToColor("#FFB967"),
              size: 40,
            ),
          ),
          Center(
            child: Container(
              padding: EdgeInsets.all(5),
              child: Image(
                image: AssetImage(
                    ChooseCategory.PACKAGE_NAME + sourceName + ".png"),
              ),
            ),
          )
        ],
      ),
    );
  }
}

Color hexToColor(String code) {
  return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
}
