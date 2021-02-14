import 'package:expense_manager/chart_try/chart_try_bloc.dart';
import 'package:expense_manager/chart_try/single_comp/simple_comp_bloc.dart';
import 'package:expense_manager/chart_try/single_comp/single_chart_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChartView extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _ChartView();
  }
}

class _ChartView extends State<ChartView> {
  final initPage = 99;
  final PageController _pageController = PageController(initialPage: 99);
  final SimpleCompBloc _simpleCompBloc = SimpleCompBloc();

  @override
  void dispose() {
    _pageController.dispose();
    _simpleCompBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChartTryBloc , ChartTryState>(builder: (context , state){
      return  Container(
        height: 100,
        width: 200,
        child: PageView.builder(
          controller: _pageController,
          itemBuilder: (context , index){
            return Container(
              margin: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                  color: Colors.red
              ),
              child: Center(
                child:
                // Text("${state.type}"),
                BlocProvider.value(
                  value: _simpleCompBloc..add(SceLoad(type: state.type)),
                  child: SingleChartView(),),
              ),
            );
          },
          itemCount: 100,
        ),
      );
    });
  }

}
