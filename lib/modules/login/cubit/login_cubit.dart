import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:poke_cubit/widgets/common/sleep.func.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  TextEditingController loginController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String get _login => loginController.text.trim();
  String get _password => passwordController.text.trim();

  LoginCubit() : super(LoginInitial());

  

  

  Future<void> login() async {
    if (_login.isEmpty || _password.isEmpty) {
      emit(LoginErrorState("Login ou senha vazios!"));
      return;
    }
    emit(LoginWaitingState());
    if (FirebaseAuth.instance.currentUser == null || FirebaseAuth.instance.currentUser?.isAnonymous == true) {
      try {
        UserCredential user = await FirebaseAuth.instance.signInWithEmailAndPassword(email: _login, password: _password);

        if (FirebaseAuth.instance.currentUser == null) {
          emit(LoginErrorState("Erro no login"));
        } else {
          emit(LoginSuscessfullState());
        }
      } catch (error) {
        emit(LoginErrorState("Usuário não encontrado"));
      }
    }
  }
}
