import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poke_cubit/modules/home/cubit/home_cubit.dart';
import 'package:poke_cubit/modules/home/home.page.dart';
import 'package:poke_cubit/modules/login/cubit/login_cubit.dart';
import 'package:poke_cubit/widgets/login/login_container.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => LoginStatefull();
}

class LoginStatefull extends State<LoginPage> with TickerProviderStateMixin {
  static const pokeballImage = AssetImage('assets/pokeball.png');

  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 1),
    vsync: this,
  )..repeat(reverse: false);
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.linear,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Center(
            heightFactor: mediaQuery.size.height * 0.001,
            child: Container(
              width: mediaQuery.size.height * .3,
              child: Image(
                fit: BoxFit.fill,
                image: pokeballImage,
              ),
            ),
          ),
          Center(
            child: BlocConsumer<LoginCubit, LoginState>(
              listener: (context, state) async {
                if (state is LoginErrorState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      behavior: SnackBarBehavior.floating,
                      margin: EdgeInsets.all(mediaQuery.size.width * .1),
                      key: Key('SnackBarDefault'),
                      backgroundColor: Colors.lightBlue,
                      content: Text(
                        state.message,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      duration: Duration(seconds: 2),
                    ),
                  );
                } else if (state is LoginSuscessfullState) {
                  String uid = FirebaseAuth.instance.currentUser!.uid;
                  var userDoc = await FirebaseFirestore.instance.collection("users").doc(uid).get();
                  String name = userDoc['name'];
                  print("nome: $name");
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => BlocProvider(
                        create: (context) => HomeCubit(),
                        child: HomePage(),
                      ),
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state is LoginWaitingState) {
                  return Container(
                    color: Colors.white30,
                    child: RotationTransition(
                      turns: _animation,
                      child: Container(width: 70, height: 70, child: Padding(padding: EdgeInsets.all(8), child: Image.asset('assets/pokeball_spin.png'))),
                    ),
                  );
                } else {
                  return LoginContainer(
                    loginController: context.read<LoginCubit>().loginController,
                    passwordController: context.read<LoginCubit>().passwordController,
                    onpressed: context.read<LoginCubit>().login,
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
