
import 'package:authentication_repository/authentication_repository.dart';
import 'package:user_repository/user_repository.dart';

class AuthenticationState {
  AuthenticationState._({
    this.user = User.empty ,
    this.status = AuthenticationStatus.unknown
  });

  final User user;
  final AuthenticationStatus status;


  AuthenticationState.authenticated(User user) : this._(user : user , status: AuthenticationStatus.authenticated);

  AuthenticationState.unknown() : this._();

  AuthenticationState.unauthenticated() : this._(status: AuthenticationStatus.unauthenticated );

}
