import 'package:flutter/material.dart';
import 'package:poke_cubit/models/pokemon.model.dart';

class PokemonDetailsPage extends StatelessWidget {
  final Pokemon pokemon;
  PokemonDetailsPage({Key? key, required this.pokemon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: (pokemon.color as Color),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.favorite),
          ),
        ],
      ),
      body: Column(children: [
        Align(
          alignment: Alignment.topCenter,
          child: Hero(
            tag: '${pokemon.id}',
            child: pokemon.getImage(width: mediaQuery.size.width * 0.7),
          ),
        ),
      ]),
    );
  }
}
