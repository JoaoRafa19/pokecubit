import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:poke_cubit/utils/utils.functions.dart';

part 'drawercubit_state.dart';

class DrawerCubit extends Cubit<DrawerState> {
  DrawerCubit() : super(DrawercubitInitial());

  logOut(BuildContext context) async {
    emit(DrawerLoading());
    await FirebaseAuth.instance.signOut();
    await sleep(2);
    emit(DrawerConcluded());
    Navigator.of(context).pushReplacementNamed('/login');
  }

  
}
