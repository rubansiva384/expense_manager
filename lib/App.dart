import 'package:authentication_repository/authentication_repository.dart';
import 'authentication/authentication_bloc.dart';
import 'authentication/authentication_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';
import 'home/view/home_page.dart';
import 'login/view/LoginPage.dart';
import 'splash/splash.dart';

class App extends StatelessWidget{
  final UserRepository userRepository;
  final AuthenticationRepository authenticationRepository;

  App({ Key key ,  @required this.userRepository , @required this.authenticationRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(value: authenticationRepository ,
        child: BlocProvider(
          create: (_) => AuthenticationBloc(authenticationRepository, userRepository),
          child: AppView(),
        )
      );
  }

}

class AppView extends StatefulWidget {
  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey,
      builder: (context , child){
        return BlocListener<AuthenticationBloc , AuthenticationState>(
            listener: (context , state){
              switch(state.status){
                case AuthenticationStatus.authenticated:
                  print("navigating to home");
                  _navigator.pushAndRemoveUntil(HomePage.route(), (route) => false);
                  break;

                case AuthenticationStatus.unauthenticated:
                case AuthenticationStatus.unknown:
                  _navigator.pushAndRemoveUntil(LoginPage.route(), (route) => false);
                  break;

                default:
                  break;
              }
            } , child: child,
        );
      },

      onGenerateRoute: (_) =>  SplashPage.route(),
    );
  }
}
