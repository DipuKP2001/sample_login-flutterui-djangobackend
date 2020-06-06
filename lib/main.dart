import 'package:bloc_login/bloc/authentication_bloc.dart';
import 'package:bloc_login/home/home.dart';
import 'package:bloc_login/repository/user_repository.dart';
import 'package:bloc_login/splash/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:bloc_login/common/common.dart';
import 'package:bloc_login/login/login_page.dart';


class SimpleBlocDelegate extends BlocDelegate {
  @override 
  void onEvent(Bloc bloc, Object event){
    super.onEvent(bloc, event);
    print(event);
  }
  @override 
  void  onTransition(Bloc bloc, Transition transition){
    super.onTransition(bloc, transition);
    print(transition);
  }
  @override 
  void  onError(Bloc bloc, Object error, StackTrace stackTrace){
    super.onError(bloc, error, stackTrace);
  }  
}

void main() {

  final userRepository = UserRepository();
  runApp(
    BlocProvider<AuthenticationBloc>(
      create: (context){
        return AuthenticationBloc(
          userRepository: userRepository
        )..add(AppStarted());
      },
      child: MyApp(userRepository: userRepository),
    )
  );
}

class MyApp extends StatelessWidget {
  final UserRepository userRepository;

  MyApp({
    Key key,
    @required this.userRepository,
  }):super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state){
          if(state is AuthenticationUninitialized){
            return SplashPage();
          }
          if(state is AuthenticationAuthenticated){
            return HomePage();
          }
          if(state is AuthenticationUnauthenticated){
            return LoginPage(userRepository: userRepository);
          }
          if(state is AuthenticationLoading){
            return LoadingIndicator();
          }
        }
      ),
    );
  }
}

