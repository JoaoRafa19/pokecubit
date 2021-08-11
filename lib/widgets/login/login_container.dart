import 'package:flutter/material.dart';

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
            controller: loginController,
          ),
          TextFormField(
            controller: passwordController,
          ),
          SizedBox(height: 20),
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
