import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:poke_cubit/utils/utils.functions.dart';

// ignore: must_be_immutable
class EndDrawer extends StatelessWidget {
  EndDrawer({Key? key}) : super(key: key);

  // ignore: close_sinks
  StreamController _streamController = StreamController<String>();

  Stream get output => _streamController.stream;
  Sink get input => _streamController.sink;
  bool _isLoading = false;

  _loading() {
    _isLoading = true;
    input.add('loading');
  }

  _concluded() {
    _isLoading = false;
    input.add('concluded');
  }

  _logOut(BuildContext context) async {
    _loading();
    await FirebaseAuth.instance.signOut();
    await sleep(2);
    _concluded();
    Navigator.of(context).pushReplacementNamed('/login');
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Drawer(
      child: Container(
        padding: EdgeInsets.only(top: screenSize.height * 0.1, left: 10, right: 10),
        child: Column(children: <Widget>[
          GestureDetector(
            onTap: () => _logOut(context),
            child: Row(
              children: [
                StreamBuilder(
                    stream: this.output,
                    builder: (context, snapshot) {
                      if (_isLoading) {
                        return CircularProgressIndicator(color: Colors.black);
                      }
                      return Icon(
                        Icons.logout,
                        size: 30,
                      );
                    }),
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
