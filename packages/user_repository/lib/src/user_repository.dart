import 'package:uuid/uuid.dart';

import 'models/user.dart';

class UserRepository{
  User _user;

  Future<User> getUser() async{
    if(_user != null) return _user;

    await Future.delayed(Duration(seconds: 2));
    return User(Uuid().v4());
  }

}