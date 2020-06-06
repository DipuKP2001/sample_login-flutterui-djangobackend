import 'dart:async';
import 'package:bloc_login/bloc/authentication_bloc.dart';
import 'package:bloc_login/repository/user_repository.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;
  final AuthenticationBloc authenticationBloc;

  LoginBloc({
    @required this.userRepository,
    @required this.authenticationBloc,
  }) : assert(userRepository != null),
  assert(authenticationBloc != null);
  @override
  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if(event is LoginButtonPressed){
      yield LoginInitial();
      try{
        final user = await userRepository.authenticate(
          username: event.username, 
          password: event.password,
        );
        authenticationBloc.add(LoggedIn(user: user));
        yield LoginInitial();
      }catch(error){
        yield LoginFailure(error: error.toString());
      }
    }
  }
}
