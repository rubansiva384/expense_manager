import 'package:expense_repository/src/model/AnalyticsEntity.dart';
import 'package:expense_repository/src/model/ExpenseEntity.dart';
import 'package:flutter/widgets.dart';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class MyDatabase{
  static Database _database;
  static MyDatabase _myDatabase;
  static const COLUMN_EXPENSE_NAME = "expense_name";
  static const COLUMN_EXPENSE_CATEGORY = "expense_category";
  static const COLUMN_EXPENSE_COUNT = "expense_row_count";
  static const COLUMN_EXPENSE_DESCRIPTION = "expense_description";
  static const COLUMN_EXPENSE_AMOUNT = "expense_amount";
  static const COLUMN_ANALYTICS_TOTAL = "expense_total";
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

  Future<List<ExpenseEntity>> getAllExpensesByMonth(int month) async{
    final Database db = await _getDatabaseInstance();
    // final String query = 'select cast(strftime("%m" , $COLUMN_TIME ,"unixepoch") as int) as month from $TABLE_EXPENSE';
    // print(query);
    // final result = await db.rawQuery(query);
    // print("result $result");
    List<Map<String, dynamic>> list = await db.query(TABLE_EXPENSE , where: 'cast(strftime("%m" , $COLUMN_TIME ,"unixepoch") as int) = ?' , whereArgs: [month] );
    List<ExpenseEntity> products = List<ExpenseEntity>();
    list.forEach((element) {
      products.add(ExpenseEntity.fromJson(element));
      // print(element);
    });
    return products;
  }

  Future<int> addExpense(ExpenseEntity expenseEntity) async{
    final Database db = await _getDatabaseInstance();
    print("inserting entity => time : ${expenseEntity.dateTime}");
    return await db.insert(TABLE_EXPENSE, expenseEntity.toJson());
  }

  Future<List<AnalyticsEntity>> getAnalytics(int month) async{
    final Database db = await _getDatabaseInstance();
    List<Map<String, dynamic>> list = await db.rawQuery("select sum($COLUMN_EXPENSE_AMOUNT) as  $COLUMN_ANALYTICS_TOTAL, $COLUMN_EXPENSE_CATEGORY , count(*) as $COLUMN_EXPENSE_COUNT , $COLUMN_TIME from $TABLE_EXPENSE where cast(strftime('%m' , $COLUMN_TIME ,'unixepoch') as int) = $month group by $COLUMN_EXPENSE_CATEGORY  ");
    List<AnalyticsEntity> products = List<AnalyticsEntity>();
    list.forEach((element) {
      products.add(AnalyticsEntity.fromJson(element));
      // print(element);
    });
    return products;
  }

  Future<List<AnalyticsEntity>> getAnalyticsByDate(DateTime dateTime) async{
    final Database db = await _getDatabaseInstance();
    //TODO check month also that could conflict
    //TODO check actual datas coming : never grouped with type(credit , debit)
    final String query = "select $COLUMN_TIME , cast(strftime('%H' , $COLUMN_TIME ,'unixepoch') as int) as HOUR_OF_MONTH , $COLUMN_EXPENSE_AMOUNT as $COLUMN_ANALYTICS_TOTAL , $COLUMN_EXPENSE_CATEGORY , $COLUMN_EXPENSE_DESCRIPTION from $TABLE_EXPENSE where cast(strftime('%d' , $COLUMN_TIME ,'unixepoch') as int) = ${dateTime.day} GROUP BY HOUR_OF_MONTH";
    List<Map<String, dynamic>> list = await db.rawQuery(query);
    print(query);
    List<AnalyticsEntity> products = List<AnalyticsEntity>();
    list.forEach((element) {
      products.add(AnalyticsEntity.fromJson(element));
      print(element);
    });
    return products;
  }


Future<List<Map<String, dynamic>>> getIncome(int month) async{
    final Database db = await _getDatabaseInstance();
    List<Map<String, dynamic>> list = await db.rawQuery("select sum($COLUMN_EXPENSE_AMOUNT) as $COLUMN_ANALYTICS_TOTAL , $COLUMN_EXPENSE_TYPE  from $TABLE_EXPENSE where cast(strftime('%m' , $COLUMN_TIME ,'unixepoch') as int) = $month group by $COLUMN_EXPENSE_TYPE  ");
    return list;
  }

  getAnalyticsByWeek(DateTime startTime , DateTime endTime) async{
    final Database db = await _getDatabaseInstance();
    //TODO check month also that could conflict
    final String query = "select cast(strftime('%d' , $COLUMN_TIME ,'unixepoch') as int) as HOUR_OF_MONTH , $COLUMN_EXPENSE_AMOUNT as $COLUMN_ANALYTICS_TOTAL , $COLUMN_EXPENSE_CATEGORY , $COLUMN_EXPENSE_DESCRIPTION from $TABLE_EXPENSE where $COLUMN_TIME >= $startTime and $COLUMN_TIME <= $endTime GROUP BY HOUR_OF_MONTH";
    List<Map<String, dynamic>> list = await db.rawQuery(query);
    // print(query);
    List<AnalyticsEntity> products = List<AnalyticsEntity>();
    list.forEach((element) {
      products.add(AnalyticsEntity.fromJson(element));
      // print(element);
    });
    return products;
  }

}