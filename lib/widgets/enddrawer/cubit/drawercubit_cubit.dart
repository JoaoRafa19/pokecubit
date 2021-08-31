import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:poke_cubit/utils/utils.functions.dart';

part 'drawercubit_state.dart';

class DrawerCubit extends Cubit<DrawerState> {
  String userEmail = '';
  String userName = '';

  DrawerCubit() : super(DrawercubitInitial());

  getData() async {
    emit(DrawerLoadingData());
    if(FirebaseAuth.instance.currentUser != null){
      User user = FirebaseAuth.instance.currentUser!;
      if(user.email != null) {
        userEmail = user.email!;
      }
      userName = (await  FirebaseFirestore.instance.collection("users").doc(user.uid).get())["name"];
    }
    emit(DrawerConcludedData());
  }

  logOut(BuildContext context) async {
    emit(DrawerLoading());
    await FirebaseAuth.instance.signOut();
    await sleep(2);
    emit(DrawerConcluded());
    Navigator.of(context).pushReplacementNamed('/login');
  }

  
}
