import 'package:expense_manager/choose_category/model/ExpenseCategory.dart';
import 'package:expense_manager/widgets/AppImage.dart';
import 'package:expense_repository/expense_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChooseCategory extends StatelessWidget {
  final int type;
  static const String PACKAGE_NAME = "assets/icons/";
  static const List<ExpenseCategory> CATEGORY_LIST = <ExpenseCategory>[
    ExpenseCategory("Entertainment" , "baseline_school_white_36dp"),
    ExpenseCategory("Education" , "baseline_school_white_36dp"),
    ExpenseCategory("Shopping" ,"round_shopping_basket_white_36dp"),
    ExpenseCategory("Personal Care" , "round_medical_services_white_36dp"),
    ExpenseCategory("Health & Fitness" , "round_fitness_center_white_36dp"),
    ExpenseCategory("Kids" , "baseline_child_friendly_white_36dp"),
    ExpenseCategory("Food & Dining" , "baseline_fastfood_white_36dp"),
    ExpenseCategory("Gifts & donations" , "baseline_card_giftcard_white_36dp"),
    ExpenseCategory("Investments" , "baseline_account_balance_white_36dp"),
    ExpenseCategory("Bills & Donations" , "baseline_credit_card_white_36dp"),
    ExpenseCategory("Auto & Transports" , "baseline_local_taxi_white_36dp"),
    ExpenseCategory("Travel" , "baseline_directions_bike_white_36dp"),
    ExpenseCategory("Fees & Charges" , "baseline_receipt_white_36dp"),
    ExpenseCategory("Business services" , "baseline_business_white_36dp"),
    ExpenseCategory("Taxes" , "baseline_money_white_36dp"),
  ];
  static const List<ExpenseCategory> INCOME_LIST = <ExpenseCategory>[
         ExpenseCategory("Wages" , "baseline_money_white_36dp"),
         ExpenseCategory("Salary" , "baseline_credit_card_white_36dp"),
         ExpenseCategory("Selling" , "baseline_store_white_36dp"),
         ExpenseCategory("Commission" , "baseline_store_white_36dp"),
         ExpenseCategory("Interest" , "baseline_receipt_white_36dp"),
         ExpenseCategory("Investments" , "baseline_business_white_36dp"),
         ExpenseCategory("Gifts" , "baseline_card_giftcard_white_36dp"),
         ExpenseCategory("Allowance" , "baseline_credit_card_white_36dp"),
         ExpenseCategory("Pension" , "baseline_money_white_36dp"),
    ];

  const ChooseCategory({Key key, this.type}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Choose category"),
      ),
      body: Container(
        child: GridView.builder(
          itemBuilder: (context , position) {
            final ExpenseCategory entity = type == ExpenseEntity.TYPE_DEBIT  ? ChooseCategory.CATEGORY_LIST[position] : ChooseCategory.INCOME_LIST[position];
            return GestureDetector(
              onTap: (){
                Navigator.pop(context , position);
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children : [
                  Circle(sourceName: entity.imageResource,) ,
                  Text(entity.name)
                ],
              ),
            );
          },
          itemCount: type == ExpenseEntity.TYPE_DEBIT ? ChooseCategory.CATEGORY_LIST.length : ChooseCategory.INCOME_LIST.length ,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3
          ),
        ),
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
            child: Icon(Icons.circle , color: Colors.blueAccent, size: 70,),
          ),
          Center(
            child: AppImage(sourceName),
          )
        ],
      ),
    );
  }
}
