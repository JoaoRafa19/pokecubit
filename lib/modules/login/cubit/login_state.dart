part of 'login_cubit.dart';

@immutable
abstract class LoginState {
  
}

class LoginInitial extends LoginState {}

class LoginWaitingState extends LoginState {}

class LoginErrorState extends LoginState {
  final message;

  LoginErrorState(this.message);
}

class LoginSuscessfullState extends LoginState {}
