import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poke_cubit/models/pokemon.model.dart';
import 'package:poke_cubit/modules/details/details.page.dart';
import 'package:poke_cubit/modules/home/cubit/home_cubit.dart';
import 'package:poke_cubit/modules/home/home.page.dart';
import 'package:poke_cubit/modules/login/cubit/login_cubit.dart';
import 'package:poke_cubit/modules/login/login.page.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (context) => BlocProvider<HomeCubit>(
            create: (_) => HomeCubit(),
            child: HomePage(),
          ),
        );
      case '/login':
        return MaterialPageRoute(
          builder: (context) => BlocProvider<LoginCubit>(
            create: (_) => LoginCubit(),
            child: LoginPage(),
          ),
        );
      case '/details':
        // Validation of correct data type
        if (args is Pokemon) {
          return MaterialPageRoute(
            builder: (context) => PokemonDetailsPage(pokemon: args),
          );
        }
        // If args is not of the correct type, return an error page.
        // You can also throw an exception while in development.
        return _errorRoute();
      default:
        // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
