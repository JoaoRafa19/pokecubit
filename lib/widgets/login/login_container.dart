import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginContainer extends StatelessWidget {
  final void Function()? onpressed;
  final TextEditingController loginController;
  final TextEditingController passwordController;
  const LoginContainer({
    Key? key,
    required this.onpressed,
    required this.loginController,
    required this.passwordController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return Container(
      padding: EdgeInsets.only(left: mediaQuery.size.width * .2, right: mediaQuery.size.width * .2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            style: GoogleFonts.lato(),
            decoration: InputDecoration(labelText: "Login"),
            controller: loginController,
          ),
          SizedBox(height: 21),
          TextFormField(
              style: GoogleFonts.lato(),
              decoration: InputDecoration(labelText: "Senha"),
              controller: passwordController,
              validator: (text) {
                String pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
                RegExp regExp = new RegExp(pattern);
                if (text != null) {
                  if (regExp.hasMatch(text)) {
                    return 'Senha com caracteres inválidos';
                  } else {
                    return null;
                  }
                }
              }),
          SizedBox(height: 27),
          Container(
            color: Colors.blueAccent[400],
            width: mediaQuery.size.width * .3,
            child: TextButton(
              child: Text("LOGIN",
                  style: TextStyle(
                    color: Colors.white,
                  )),
              onPressed: onpressed,
            ),
          ),
        ],
      ),
    );
  }
}
