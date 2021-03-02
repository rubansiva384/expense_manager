import 'package:expense_manager/analytics/bloc/analytics_bloc.dart';
import 'package:expense_manager/analytics_pie/analytics_pie_view.dart';
import 'package:expense_manager/analytics_pie/bloc/analytics_pie_bloc.dart';
import 'package:expense_manager/choose_category/choose_category.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AnalyticsListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AnalyticsBloc, AnalyticsState>(
        builder: (context, state) {
          if (state.entities != null) {
            return Container(
              child: Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    final categoryId = state.entities[index].category;
                    final category = ChooseCategory.CATEGORY_LIST[categoryId];
                    return ListRowDaily(
                      expenseCategory: category,
                      entity: state.entities[index],
                    );
                  },
                  itemCount: state.entities.length,
                ),
              ),
            );
          } else
            return CircularProgressIndicator();
        });
  }
}