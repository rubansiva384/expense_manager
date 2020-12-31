// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';


void main() {
  testWidgets('Datetime formatter test', (WidgetTester tester) async {
    final date = DateTime.fromMillisecondsSinceEpoch(1605154500000);
    final month = DateFormat("MM").format(date);
    expect( month , '11');
  });

  testWidgets('Databae Insert Test', (WidgetTester tester) async {

  });
}
