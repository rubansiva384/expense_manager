import 'package:expense_repository/src/model/ExpenseEntity.dart';
import 'package:flutter/widgets.dart';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class MyDatabase{
  static Database _database;
  static MyDatabase _myDatabase;
  static const COLUMN_EXPENSE_NAME = "expense_name";
  static const COLUMN_EXPENSE_CATEGORY = "expense_category";
  static const COLUMN_EXPENSE_DESCRIPTION = "expense_description";
  static const COLUMN_EXPENSE_AMOUNT = "expense_amount";
  static const COLUMN_TIME = "entered_time";
  static const COLUMN_EXPENSE_TYPE = "expense_type";
  static const COLUMN_IMAGE = "expense_image";
  static const TABLE_EXPENSE = "expense";

  static MyDatabase getInstance() {
    if(_myDatabase == null){
      _myDatabase = MyDatabase();
    }
    return _myDatabase;
  }

  Future<Database> _getDatabaseInstance() async{
    if(_database == null){
      WidgetsFlutterBinding.ensureInitialized();
      final Future<Database> database = openDatabase(
        join(await getDatabasesPath(), 'expense_db.db'),
        onCreate: (db, version) {
          return db.execute(
            // TODO expense type always could be 2 possible types(credit debit) so remove with boolean if available in sqlite;
            "CREATE TABLE $TABLE_EXPENSE($COLUMN_EXPENSE_DESCRIPTION varchar(50) , $COLUMN_EXPENSE_TYPE INTEGER ,  $COLUMN_EXPENSE_AMOUNT INTEGER  ,  $COLUMN_EXPENSE_CATEGORY INTEGER  , $COLUMN_TIME INTEGER , $COLUMN_IMAGE varchar(50) )",
          );
        },
        version: 1,
      );
      _database =  await database;
    }
      return _database;
  }

  Future<List<ExpenseEntity>> getAllExpenses() async{
    final Database db = await _getDatabaseInstance();
    List<Map<String, dynamic>> list = await db.query(TABLE_EXPENSE);
    List<ExpenseEntity> products = List<ExpenseEntity>();
    list.forEach((element) {
      products.add(ExpenseEntity.fromJson(element));
    });
    return products;
  }

  Future<int> addExpense(ExpenseEntity expenseEntity) async{
    final Database db = await _getDatabaseInstance();
    return await db.insert(TABLE_EXPENSE, expenseEntity.toJson());
  }

}