import 'package:expense_manager/chart_try/single_comp/simple_comp_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SingleChartView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SimpleCompBloc, SimpleCompState>(builder: (context , state){
      if(state.list == null){
        return Container(
          child: Text("Loading"),
        );
      }
      else if(state.list != null){
        return Container(
          child: Text("${state.type}${state.list.length}"),
        );
      }
      return CircularProgressIndicator();
    });
  }
}
