import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:poke_cubit/modules/login/cubit/login_cubit.dart';
import 'package:poke_cubit/modules/login/login.page.dart';

class EndDrawer extends StatelessWidget {
  const EndDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Drawer(
      child: Container(
        padding: EdgeInsets.only(top: screenSize.height * 0.1, left: 10, right: 10),
        child: Column(children: <Widget>[
          GestureDetector(
            onTap: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BlocProvider(create: (context) => LoginCubit(), child: LoginPage())),
              );
            },
            child: Row(
              children: [
                Icon(
                  Icons.logout,
                  size: 30,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    "Logout",
                    style: GoogleFonts.rubik(fontSize: 30),
                  ),
                )
              ],
            ),
          )
        ]),
      ),
    );
  }
}
