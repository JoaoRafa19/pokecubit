import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  TextEditingController loginController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String get _login => loginController.text.trim();
  String get _password => passwordController.text.trim();

  LoginCubit() : super(LoginInitial());

  Future<void> login() async {
    emit(LoginWaitingState());
    print(FirebaseAuth.instance.currentUser);
    if (FirebaseAuth.instance.currentUser == null || FirebaseAuth.instance.currentUser?.isAnonymous == true) {
      UserCredential user = await FirebaseAuth.instance.signInWithEmailAndPassword(email: _login, password: _password);
      if (user.credential?.token == null) {
        emit(LoginErrorState());
      } else {
        emit(LoginSuscessfullState());
      }
    }
  }
}
