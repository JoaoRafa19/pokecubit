import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poke_cubit/modules/signup/cubit/signup_cubit.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro'),
        centerTitle: true,
        backgroundColor: Colors.lightBlue,
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () => Navigator.of(context).pop()),
      ),
      body: Form(
        child: BlocConsumer<SignupCubit, SignUpState>(
          listener: (context, state) {
            if (state is SignUpError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  behavior: SnackBarBehavior.floating,
                  margin: EdgeInsets.all(mediaQuery.size.width * .1),
                  key: Key('SnackBarDefault'),
                  backgroundColor: Colors.lightBlue,
                  content: Text(
                    state.errorMessage!,
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
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.only(left: 10),
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Theme.of(context).primaryColorLight,
                  ),
                  child: TextFormField(
                    controller: context.read<SignupCubit>().nameController,
                    decoration: InputDecoration(
                      focusedBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      border: InputBorder.none,
                      icon: Icon(Icons.text_fields),
                      labelText: 'Nome',
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 10),
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Theme.of(context).primaryColorLight,
                  ),
                  child: TextFormField(
                    controller: context.read<SignupCubit>().emailController,
                    decoration: InputDecoration(
                      focusedBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      border: InputBorder.none,
                      icon: Icon(Icons.mail),
                      labelText: 'Email',
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 10),
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Theme.of(context).primaryColorLight,
                  ),
                  child: TextFormField(
                    controller: context.read<SignupCubit>().passwordController,
                    keyboardType: TextInputType.text,
                    enableSuggestions: false,
                    obscureText: true,
                    decoration: InputDecoration(
                      focusedBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      border: InputBorder.none,
                      icon: Icon(Icons.lock),
                      labelText: 'senha',
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 28),
                  decoration: BoxDecoration(
                    color: Colors.blue[200],
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: MaterialButton(
                    child: Text("cadastrar"),
                    onPressed: () async {
                      await context.read<SignupCubit>().signup();
                    },
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
