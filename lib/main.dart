import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:poke_cubit/utils/generate_routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(PokecubitApp());
}

class PokecubitApp extends StatelessWidget {
  static final FirebaseAuth auth = FirebaseAuth.instance;
  PokecubitApp() {
    //auth.signOut();
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
      onGenerateRoute: RouteGenerator.generateRoute,
      initialRoute: auth.currentUser == null || auth.currentUser!.isAnonymous ? '/login' : '/',
    );
  }
}
