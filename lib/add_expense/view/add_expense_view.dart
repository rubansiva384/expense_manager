import 'package:expense_manager/add_expense/bloc/add_expense_bloc.dart';
import 'package:expense_manager/choose_category/choose_category.dart';
import 'package:expense_manager/choose_category/model/ExpenseCategory.dart';
import 'package:expense_manager/util/Utility.dart';
import 'package:expense_repository/expense_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

typedef OnCategoryChosen(int id);

class AddExpenseView extends StatelessWidget {
  final TextEditingController _controllerDescription = TextEditingController();
  final TextEditingController _controllerAmount = TextEditingController();
  static const String LABEL_TIME = "TIME *";
  static const String LABEL_CATEGORY = "CATEGORY *";
  static const String LABEL_AMOUNT = "AMOUNT *";
  static const String LABEL_DESCRIPTION = "DESCRIPTION";
  final BoxDecoration _boxDecoration =
      BoxDecoration(border: Border.all(width: 1.3, color: Colors.black26));

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.black12),
      child: Container(
        margin: EdgeInsets.all(45),
        child: Center(
          child: Container(
            padding: EdgeInsets.only(left: 30.0, right: 30.0 , bottom: 20.0),
            decoration: BoxDecoration(color: Colors.white),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InputBox(
                  label: LABEL_DESCRIPTION,
                  controller: _controllerDescription,
                  boxDecoration: _boxDecoration,
                ),
                InputDateTime(_boxDecoration),
                InputBox(
                  label: LABEL_AMOUNT,
                  controller: _controllerAmount,
                  boxDecoration: _boxDecoration,
                ),
                InputChooseCategory(null, _boxDecoration, (position) {
                  context
                      .read<AddExpenseBloc>()
                      .add(CategoryChanged(categoryId: position));
                }),
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

  void save(BuildContext context) {
    context.read<AddExpenseBloc>().add(EventAddBill(
        description: _controllerDescription.text,
        amount: _controllerAmount.text,
        type: ExpenseEntity.TYPE_DEBIT
    ));
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
            keyboardType: this.label == AddExpenseView.LABEL_AMOUNT ? TextInputType.number : TextInputType.text,
            onChanged: (text) {
             if (this.label == AddExpenseView.LABEL_DESCRIPTION) {
                context
                    .read<AddExpenseBloc>()
                    .add(DescriptionChange(desc: text));
              } else if (this.label == AddExpenseView.LABEL_AMOUNT) {
                context.read<AddExpenseBloc>().add(AmountChanged(amount: text));
              }
            },
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
  final int categoryId;
  final BoxDecoration _boxDecoration;
  final OnCategoryChosen categoryChosen;

  InputChooseCategory(this.categoryId, this._boxDecoration, this.categoryChosen);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddExpenseBloc, AddExpenseState>(
        builder: (context, state) {
          ExpenseCategory expenseCategory;
          if(state.categoryId != null)
            expenseCategory = ChooseCategory.CATEGORY_LIST[state.categoryId];
          return GestureDetector(
            onTap: () async {
              final int categoryPosition = await Navigator.push(
                  context, MaterialPageRoute(builder: (context) => ChooseCategory()));
              categoryChosen(categoryPosition);
            },
            child: Container(
              margin: EdgeInsets.only(top: 20.0),
              child: Column(
                children: [
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        padding: EdgeInsets.only( bottom: 5),
                        child: Text("CATEGORY *"),
                      )),
                  Container(
                    decoration: _boxDecoration,
                    padding: EdgeInsets.all(5),
                    child: Row(
                      children: [
                        Circle(
                          sourceName: expenseCategory != null ? expenseCategory.imageResource : "",
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 5),
                          child: Text(
                            expenseCategory != null  ? expenseCategory.name  : "Select a category",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}

class InputDateTime extends StatelessWidget {
  final BoxDecoration _boxDecoration;

  InputDateTime(this._boxDecoration, );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddExpenseBloc, AddExpenseState>(
        builder: (context, state) {
          return GestureDetector(
            onTap: () async {
              final date = await showDatePicker(context: context , initialDate: DateTime.now() , firstDate: DateTime(2000), lastDate: DateTime.now());
              final time = await showTimePicker(context: context , initialTime: TimeOfDay.now());
              final actTime = date.add(Duration(hours: time.hour , minutes: time.minute));
              context.read<AddExpenseBloc>().add(TimeChanged(time: actTime.millisecondsSinceEpoch));
            },
            child: Container(
              margin: EdgeInsets.only(top: 20.0),
              child: Column(
                children: [
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        padding: EdgeInsets.only( bottom: 5),
                        child: Text("TIME *"),
                      )),
                  Container(
                    decoration: _boxDecoration,
                    padding: EdgeInsets.all(15.0),
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 5),
                          child: Text(
                            Utility.getInstance().getTime("dd/MM/yyyy hh:mm:ss", state.time) ,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}


class SaveButton extends StatelessWidget {
  final VoidCallback callback;

  SaveButton(this.callback);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: hexToColor("#FFB967")),
      margin: EdgeInsets.only(top: 70),
      padding: EdgeInsets.all(10.0),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: callback,
                child: Align(
                    child: Text(
              "Add Bill",
              style: TextStyle(color: Colors.black),
            ))),
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
              child: Image(
                width: 20,
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
