import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'simple_comp_event.dart';
part 'simple_comp_state.dart';

class SimpleCompBloc extends Bloc<SimpleCompEvent, SimpleCompState> {
  SimpleCompBloc() : super(SimpleCompState());

  @override
  Stream<SimpleCompState> mapEventToState(
    SimpleCompEvent event,
  ) async* {
    if(event is SceLoad){
      // sleep(Duration(seconds: 3));
      yield SimpleCompState();
      await Future.delayed(Duration(seconds: 3));
      final list= List<String>();
      list.add("raja");
      yield SimpleCompState(list: list , type: event.type);
    }
  }
}
