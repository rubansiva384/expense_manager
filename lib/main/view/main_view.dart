import 'package:expense_manager/main/bloc/main_bloc.dart';
import 'package:expense_repository/expense_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainView extends StatelessWidget {
  Widget build(BuildContext context) {
    // ignore: missing_return
    return BlocBuilder<MainBloc, MainState>(builder: (context , state){
      if(state is MainInitial){
         return Container(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      }else if( state is MainLoaded){
        return Container(
          child: ListView.builder(itemBuilder: (context , int){
            ExpenseEntity entity = state.entities[int];
            return ListTile(title: Text("${entity.name}"),);
          }, itemCount: state.entities.length,
          ),
        );
      }
    });
  }
}
