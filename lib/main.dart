import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:poke_cubit/modules/home/cubit/home_cubit.dart';
import 'package:poke_cubit/modules/home/home.page.dart';
import 'package:poke_cubit/modules/login/cubit/login_cubit.dart';
import 'package:poke_cubit/modules/login/login.page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final FirebaseAuth auth = FirebaseAuth.instance;
  MyApp() {
    if (auth.currentUser != null) {
      if (auth.currentUser!.isAnonymous) {
        auth.signOut();
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PokeCubit',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue, textTheme: GoogleFonts.robotoTextTheme()),
      home: C == null || auth.currentUser!.isAnonymous
          ? BlocProvider<LoginCubit>(
              create: (context) => LoginCubit(),
              child: LoginPage(),
            )
          : BlocProvider<HomeCubit>(
              create: (context) => HomeCubit(),
              child: HomePage(),
            ),
    );
  }
}
