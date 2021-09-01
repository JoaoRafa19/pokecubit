import 'package:flutter/material.dart';

Future<void> sleep(int seconds) async {
  return await Future.delayed(Duration(seconds: seconds));
}

showSnackBar(context, String message, int snackBarDuration) {
    var mediaQuery = MediaQuery.of(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(mediaQuery.size.width * .1),
        key: Key('SnackBarDefault'),
        backgroundColor: Colors.lightBlue,
        content: Text(
          message,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        duration: Duration(seconds: snackBarDuration),
      ),
    );
  }