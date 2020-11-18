import 'package:expense_repository/src/model/ExpenseEntity.dart';
import 'package:flutter/widgets.dart';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class MyDatabase{
  static Database _database;
  static MyDatabase _myDatabase;
  static const COLUMN_PRODUCT_NAME = "product_name";
  static const COLUMN_PRODUCT_QUANTITY = "product_quantity";
  static const COLUMN_PRODUCT_TIME = "product_time";
  static const TABLE_PRODUCT_TIME = "products";

  static MyDatabase getMyDatabase() {
    if(_myDatabase == null){
      _myDatabase = MyDatabase();
    }
    return _myDatabase;
  }


  static getDatabaseInstance() async{
    if(_database == null){
      WidgetsFlutterBinding.ensureInitialized();
      // Open the database and store the reference.
      final Future<Database> database = openDatabase(
        // Set the path to the database. Note: Using the `join` function from the
        // `path` package is best practice to ensure the path is correctly
        // constructed for each platform.
        join(await getDatabasesPath(), 'doggie_database.db'),
        // When the database is first created, create a table to store dogs.
        onCreate: (db, version) {
          return db.execute(
            "CREATE TABLE $TABLE_PRODUCT_TIME($COLUMN_PRODUCT_NAME varchar(50), $COLUMN_PRODUCT_QUANTITY varchar(50) , $COLUMN_PRODUCT_TIME INTEGER)",
          );
        },
        // Set the version. This executes the onCreate function and provides a
        // path to perform database upgrades and downgrades.
        version: 1,
      );
      return database;
    }else
      return _database;
  }

  Future<List<ExpenseEntity>> getAllExpenses() async{
    final Database db = await getDatabaseInstance();
    List<Map<String, dynamic>> list = await db.query(TABLE_PRODUCT_TIME);
    List<ExpenseEntity> products = List<ExpenseEntity>();
    list.forEach((element) {
      products.add(ExpenseEntity.fromJson(element));
    });
    return products;
  }

  Future<void> addExpense(ExpenseEntity expenseEntity) async{
    final Database db = await getDatabaseInstance();
    await db.insert(TABLE_PRODUCT_TIME, expenseEntity.toJson());
  }

}