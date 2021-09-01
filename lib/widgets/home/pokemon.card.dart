import 'package:flutter/material.dart';
import 'package:poke_cubit/models/pokemon.model.dart';

class PokeCard extends StatelessWidget {
  final Pokemon pokemon;
  final Color? color;
  final int index;
  const PokeCard({required this.pokemon, this.color, required this.index});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/details', arguments: pokemon),
      child: Container(
        decoration: BoxDecoration(
          color: this.pokemon.color != null ? this.pokemon.color : Colors.red,
          borderRadius: BorderRadius.circular(28),
        ),
        child: Padding(
          padding: const EdgeInsets.all(7),
          child: Stack(
            alignment: Alignment.topLeft,
            children: [
              Align(
                alignment: Alignment.bottomRight,
                child: Opacity(
                  opacity: 0.35,
                  child: Image.asset(
                    "assets/pokeball_dark.png",
                    color: Colors.black,
                    height: height * 0.3,
                    width: width * 0.3,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Hero(
                  tag: '${pokemon.id}',
                  child: pokemon.getImage(heigh: height * 0.3, width: width * 0.3),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: width * .05),
                child: Text(
                  pokemon.name!,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Google',
                    fontSize: 21,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: typesColumn(),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget typesColumn() {
    List<Widget> lista = [];
    this.pokemon.type!.forEach((type) {
      lista.add(Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white.withAlpha(80),
            ),
            child: Padding(
              padding: EdgeInsets.all(6),
              child: Text(
                type.trim(),
                maxLines: 1,
                style: TextStyle(
                  fontFamily: 'Google',
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(height: 5)
        ],
      ));
    });
    return Column(
      children: lista,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
    );
  }
}
