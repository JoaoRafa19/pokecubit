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
        if (args is Pokemon) {
          return PageRouteBuilder(
            transitionDuration: Duration(seconds: 3),
            pageBuilder: (_, __, ___) => PokemonDetailsPage(pokemon: args),
          );
        }
        return _errorRoute();
      default:
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
