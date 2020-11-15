import 'package:authentication_repository/authentication_repository.dart';

abstract class AuthenticationEvent {
  AuthenticationEvent({this.status});

  AuthenticationStatus status;
}

class AuthenticationStateChanged extends AuthenticationEvent{
  AuthenticationStateChanged(AuthenticationStatus authenticationStatus) : super(status: authenticationStatus);
}

class AuthenticationLogoutRequested extends AuthenticationEvent{

}
