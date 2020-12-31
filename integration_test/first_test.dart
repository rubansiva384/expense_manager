
import 'package:expense_repository/expense_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main(){
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();


  testWidgets("First Test", (WidgetTester tester) async{
    expect(2 + 2, equals(4));

    ExpenseRepository expenseRepository = ExpenseRepository();
    await expenseRepository.addExpense(ExpenseEntity());
    expect(1 , 1);
  });
}