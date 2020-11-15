import 'dart:async';

import 'package:meta/meta.dart';

enum AuthenticationStatus { authenticated , unauthenticated , unknown }

class AuthenticationRepository{
    final  _controller = StreamController<AuthenticationStatus>();

    Stream<AuthenticationStatus> get status async*{
      await Future.delayed(const Duration(seconds: 3));
      yield AuthenticationStatus.unauthenticated;
      yield* _controller.stream;
    }

    Future<void> login({@required String username ,@required String password}) async{
      await Future.delayed(const Duration(seconds: 3) , () => _controller.add(AuthenticationStatus.authenticated));
    }

    void logout(){
      _controller.add(AuthenticationStatus.unauthenticated);
    }

    void dispose() => _controller.close();

}