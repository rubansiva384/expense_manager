part of 'simple_comp_bloc.dart';

@immutable
abstract class SimpleCompEvent {

}


class SceLoad extends SimpleCompEvent{
  final String type;

  SceLoad({this.type});
}