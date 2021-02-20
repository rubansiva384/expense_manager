import 'package:expense_manager/analytics/AnalyticsView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/analytics_bloc.dart';


class AnalyticsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (_) => AnalyticsBloc() , child: AnalyticsView(),);
  }
}
