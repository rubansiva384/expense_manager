import 'package:authentication_repository/authentication_repository.dart';
import 'package:expense_manager/App.dart';
import 'package:expense_manager/ScrollApp.dart';
import 'package:flutter/material.dart';
import 'package:user_repository/user_repository.dart';

void main() {
  runApp(
      // App(userRepository: UserRepository() , authenticationRepository: AuthenticationRepository(),)
    ScrollApp()
  );
}

