import 'package:intl/intl.dart';

class Utility{
  static Utility instance;

  static Utility getInstance(){
    if(instance == null){
      instance = Utility._();
    }
    return instance;
  }

  Utility._();

  String getTime(String format , int time ){
    final dateFormat = DateFormat(format);
    return dateFormat.format(DateTime.fromMillisecondsSinceEpoch(time));
  }

}