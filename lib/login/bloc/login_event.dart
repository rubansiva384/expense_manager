part of 'login_bloc.dart';

abstract class LoginEvent {
  const LoginEvent();
}

class UserNameChanged extends LoginEvent{

  UserNameChanged(this.username);

  final String username;
}

class PasswordChanged extends LoginEvent{

  PasswordChanged(this.password);

  final String password;
}

class LoginRequested extends LoginEvent{
  const LoginRequested();
}