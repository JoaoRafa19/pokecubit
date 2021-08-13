part of 'signup_cubit.dart';

@immutable
abstract class SignUpState {}

class SignUpInitial extends SignUpState {}

class SignUpSussesfully extends SignUpState {}

class SignUpError extends SignUpState {
  final String? errorMessage;
  
  SignUpError(this.errorMessage);
}
