import 'package:bloc_login/bloc/authentication_bloc.dart';
import 'package:bloc_login/login/bloc/login_bloc.dart';
import 'package:bloc_login/login/login_form.dart';
import 'package:bloc_login/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class LoginPage extends StatelessWidget {

  final UserRepository userRepository;

  LoginPage({
    Key key,
    @required this.userRepository,
  }) : assert(userRepository != null),
  super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login | Home-hub"),
      ),
      body: BlocProvider(
        create: (context){
          return LoginBloc(
            userRepository: userRepository, 
            authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
          );
        },
        child: LoginForm(),
      ),
    );
  }
}