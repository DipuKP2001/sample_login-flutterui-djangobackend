import 'dart:async';
import 'package:bloc_login/repository/user_repository.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:bloc_login/model/user_model.dart';
import 'package:equatable/equatable.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  
  final UserRepository userRepository;

  AuthenticationBloc({this.userRepository}) : assert(UserRepository != null);
  
  @override
  AuthenticationState get initialState => AuthenticationUninitialized();

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if(event is AppStarted){
      final bool hasToken = await userRepository.hasToken();
      if(hasToken) {
        yield AuthenticationAuthenticated();
      }else{
        yield AuthenticationUnauthenticated();
      }
    }
    if(event is LoggedIn){
      yield AuthenticationLoading();
      await userRepository.persistToken(user: event.user);
      yield AuthenticationAuthenticated();
    }
    if(event is LoggedOut){
      yield AuthenticationLoading();
      await userRepository.deleteToken(id: 0);
      yield AuthenticationUnauthenticated();
    }
  }
}
