import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poke_cubit/modules/home/cubit/home_cubit.dart';
import 'package:poke_cubit/modules/home/home.page.dart';
import 'package:poke_cubit/modules/login/cubit/login_cubit.dart';
import 'package:poke_cubit/modules/signup/cubit/signup_cubit.dart';
import 'package:poke_cubit/widgets/login/login_container.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);
  static const pokeballImage = AssetImage('assets/pokeball.png');

  @override
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
              listener: (context, state) {
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
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => BlocProvider<HomeCubit>(
                        create: (context) => HomeCubit(),
                        child: HomePage(),
                      ),
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state is LoginWaitingState) {
                  return Container(color: Colors.white30, child: CircularProgressIndicator(color: Colors.black));
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
