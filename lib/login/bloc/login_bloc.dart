import 'dart:async';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:expense_manager/login/models/models.dart';
import 'package:formz/formz.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthenticationRepository _authenticationRepository;

  LoginBloc(this._authenticationRepository) : super(LoginState());

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if(event is UserNameChanged){
      yield* _mapUserNameChangedEventToState(event, state);
    }else if (event is PasswordChanged){
      yield* _mapPasswordChangedEventToState(event, state);
    }else if(event is LoginRequested){
      yield* _mapLoginEventToState(event, state);
    }
  }

  Stream<LoginState> _mapUserNameChangedEventToState(UserNameChanged event , LoginState state) async*{
    final Username username = Username.dirty(event.username);
    yield state.copyWith(username: username , status: Formz.validate([username , state.password]));
  }

  Stream<LoginState> _mapPasswordChangedEventToState(PasswordChanged event , LoginState state) async*{
    final Password password = Password.dirty(event.password);
    yield state.copyWith(password: password , status: Formz.validate([password , state.username]));
  }

  Stream<LoginState> _mapLoginEventToState(LoginRequested event , LoginState state) async*{
    if(state.status.isValidated){
      yield state.copyWith(status: FormzStatus.submissionInProgress);

      await _authenticationRepository.login(username: state.username.value, password: state.password.value);

      yield state.copyWith(status: FormzStatus.submissionSuccess);
    }
  }

}
