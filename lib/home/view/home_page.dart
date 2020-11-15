import 'package:expense_manager/authentication/authentication_bloc.dart';
import 'package:expense_manager/authentication/authentication_event.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {

  static Route route(){
    return MaterialPageRoute(builder: (_) => HomePage());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Builder(
          builder: (context) {
            String id =
                context.select((AuthenticationBloc bloc) => bloc.state.user.id);
            return Text(id);
          },
        ),
        RaisedButton(
            child: Text("Logout"),
            onPressed: () {
              context
                  .read<AuthenticationBloc>()
                  .add(AuthenticationLogoutRequested());
            })
      ],
    );
  }
}
