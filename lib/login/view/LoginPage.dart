import 'package:authentication_repository/authentication_repository.dart';
import 'package:expense_manager/login/bloc/login_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'LoginView.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login"),),
      body: BlocProvider(
        create: (_) => LoginBloc(RepositoryProvider.of<AuthenticationRepository>(context))
        , child: LoginView(),
      ),
    );
  }

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => LoginPage());
  }
}
