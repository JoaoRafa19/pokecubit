import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poke_cubit/modules/login/cubit/login_cubit.dart';
import 'package:poke_cubit/widgets/login/login_container.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        color: Colors.white,
        child: Center(
          child: BlocConsumer<LoginCubit, LoginState>(
            listener: (context, state) {
              if (state is LoginErrorState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
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
              }
            },
            builder: (context, state) {
              if (state is LoginInitial) {
                return LoginContainer(
                  loginController: context.read<LoginCubit>().loginController,
                  passwordController: context.read<LoginCubit>().passwordController,
                  onpressed: context.read<LoginCubit>().login,
                );
              } else if (state is LoginWaitingState) {
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
      ),
    );
  }
}
