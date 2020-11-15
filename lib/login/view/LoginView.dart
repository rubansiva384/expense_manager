import 'package:expense_manager/login/bloc/login_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if(state.status.isSubmissionFailure)
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Authentication Failure"),
        ));
      },
      child: Column(
        children: [
          _UsernameInput(),
          Padding(
            padding: EdgeInsets.all(12),
          ),
          _PasswordInput(),
          const Padding(
            padding: EdgeInsets.all(12),
          ),
          _LoginButton()
        ],
      ),
    );
  }
}

class _UsernameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc , LoginState>(
        buildWhen: (previous, current) => previous.username != current.username,
        builder: (context, state) {
          return TextField(
            onChanged: (username) =>
                context.read<LoginBloc>().add(UserNameChanged(username)),
            decoration: InputDecoration(
                labelText: "Username",
                errorText: state.username.invalid ? 'invalid username' : null),
          );
        });
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return TextField(
        onChanged: (password) =>
            context.read<LoginBloc>().add(PasswordChanged(password)),
        decoration: InputDecoration(
            labelText: "Password",
            errorText: state.password.invalid ? "password empty" : null),
      );
    });
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return state.status.isSubmissionInProgress
          ? CircularProgressIndicator()
          : RaisedButton(
            child: Text("Login"),
              onPressed: () => context.read<LoginBloc>().add(LoginRequested()),
            );
    });
  }
}
