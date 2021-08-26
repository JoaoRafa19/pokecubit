import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'cubit/drawercubit_cubit.dart';

// ignore: must_be_immutable
class EndDrawer extends StatelessWidget {
  EndDrawer({Key? key}) : super(key: key);

  // ignore: close_sinks

  @override
  Widget build(BuildContext buildContext) {
    var screenSize = MediaQuery.of(buildContext).size;
    return BlocBuilder<DrawerCubit, DrawerState>(
      builder: (context, state) {
        DrawerCubit _cubit = context.watch<DrawerCubit>();
        return Drawer(
          child: Container(
            padding: EdgeInsets.only(top: screenSize.height * 0.1, left: 10, right: 10),
            child: Column(children: <Widget>[
              GestureDetector(
                onTap: () => _cubit.logOut(context),
                child: Row(
                  children: [
                    state is DrawerLoading
                        ? CircularProgressIndicator(color: Colors.black)
                        : Icon(
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
      },
    );
  }
}
