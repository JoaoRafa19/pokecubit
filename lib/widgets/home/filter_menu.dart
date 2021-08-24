import 'package:flutter/material.dart';

showFilterMenu(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Container(
            child: Column(children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 25),
                child: Row(
                  children: [
                    Chip(
                      label: Text("Teste"),
                    )
                  ],
                ),
              )
            ]),
          ),
        );
      });
}
