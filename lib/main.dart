import 'package:expense_manager/main/view/MainPage.dart';
import 'package:expense_repository/expense_repository.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
      // App(userRepository: UserRepository() , authenticationRepository: AuthenticationRepository(),)
    MainPage(ExpenseRepository())
  );
}

