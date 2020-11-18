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
            return ListRow(title: entity.name,);
          }, itemCount: state.entities.length,
          ),
        );
      }
    });
  }
}

class ListRow extends StatelessWidget {
  final String title;

  ListRow({this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.all(10.0),
            child: Circle(),
          ),
          Container(
            margin: EdgeInsets.only(left: 10),
            child:  Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Text(title , style: TextStyle(fontSize: 20 , fontWeight: FontWeight.bold), textAlign: TextAlign.left,)  ,
                )
                ,
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(title , style: TextStyle(fontSize: 15) ,),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Circle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      child: Stack(
        children: [
          Icon(Icons.circle , color: Colors.blueAccent, size: 60,),
          Center(
            child: Icon(Icons.add , color: Colors.white, size: 35,),
          )
        ],
      ),
    );
  }
}


