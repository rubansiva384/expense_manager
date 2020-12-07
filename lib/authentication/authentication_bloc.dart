import 'dart:async';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:user_repository/user_repository.dart';
import 'package:bloc/bloc.dart';
import 'authentication_event.dart';
import 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepository _authenticationRepository;
  final UserRepository _userRepository;

  AuthenticationBloc(this._authenticationRepository , this._userRepository) : super(AuthenticationState.unknown()){
    _authenticationRepository.status.listen((event) {
      add(AuthenticationStateChanged(event));
    });
  }


  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if(event is AuthenticationStateChanged){
      AuthenticationState state = await _mapAuthenticationStateChangedToState(event);
      yield state;
    }else if (event is AuthenticationLogoutRequested){
      _authenticationRepository.logout();
    }
  }

  Future<AuthenticationState> _mapAuthenticationStateChangedToState(AuthenticationStateChanged event) async {
    switch(event.status){
      case AuthenticationStatus.unauthenticated:
        return AuthenticationState.unauthenticated();

      case AuthenticationStatus.authenticated:
        return AuthenticationState.authenticated(await _userRepository.getUser());

      default:
        return AuthenticationState.unknown();
    }
  }
}
