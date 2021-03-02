import 'package:intl/intl.dart';

class Utility{
  static Utility _instance;

  static Utility getInstance(){
    if(_instance == null){
      _instance = Utility._();
    }
    return _instance;
  }

  Utility._();

  String getTime(String format , int time ){
    final dateFormat = DateFormat(format);
    return dateFormat.format(DateTime.fromMillisecondsSinceEpoch(time));
  }

  DateTime getTimeInstance(){
    final currentTime = DateTime.now();
    final time = DateTime(currentTime.year , currentTime.month , currentTime.day);
    return time;
  }

}