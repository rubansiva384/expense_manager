part of 'login_bloc.dart';

class LoginState {
  const LoginState({
    this.username = const Username.pure() , this. password = const Password.pure(), this.status = FormzStatus.pure
});

  final Username username;
  final Password password;
  final FormzStatus status;

  LoginState copyWith({FormzStatus status , Username username , Password password}){
    return LoginState(
      username: username ?? this.username ,
      password: password ?? this.password ,
      status:  status ?? status
    );
  }

}
