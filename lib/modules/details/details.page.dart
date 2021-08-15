import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
      body: Stack(
        fit: StackFit.expand,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Align(
              alignment: Alignment.topCenter,
              child: Hero(
                tag: '${pokemon.id}',
                child: pokemon.getImage(width: mediaQuery.size.width * 0.7),
              ),
            ),
          ),
          DraggableScrollableSheet(
              minChildSize: 0.25,
              maxChildSize: 0.90,
              expand: true,
              builder: (context, controller) {
                return Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(120),
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                      ),
                      height: 100,
                      width: 100,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 25, left: 10),
                        child: ListView(
                          controller: controller,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: Text(
                                    "${pokemon.name}",
                                    style: GoogleFonts.nunito(fontSize: 40, fontWeight: FontWeight.w800, color: Colors.grey[700]),
                                  ),
                                )
                              ],
                            ),
                            titleAndDetailWidget("Tipos", typesRow()),
                            titleAndDetailWidget("Altura:", detailWidget("${pokemon.height}")),
                            titleAndDetailWidget("Peso:", detailWidget("${pokemon.weight}")),
                            titleAndDetailWidget("egg:", detailWidget("${pokemon.egg}")),
                            titleAndDetailWidget("candy:", detailWidget("${pokemon.candy}")),
                            titleAndDetailWidget("spawn_time:", detailWidget("${pokemon.spawnTime}")),
                          ],
                        ),
                      )),
                );
              })
        ],
      ),
    );
  }

  Widget titleAndDetailWidget(String title, Widget content) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(title, style: GoogleFonts.lato(fontSize: 20, fontWeight: FontWeight.bold)),
        ),
        content,
      ],
    );
  }

  Widget typesRow() {
    List<Widget> lista = [];
    this.pokemon.type!.forEach((type) {
      lista.add(Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 2.5, right: 2.5),
            margin: EdgeInsets.only(left: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: pokemon.color.withAlpha(150),
            ),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                type.trim(),
                style: TextStyle(
                  fontFamily: 'Google',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(width: 5, height: 5)
        ],
      ));
    });
    return Row(
      children: lista,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
    );
  }

  Widget detailWidget(String text) {
    return Container(
      padding: EdgeInsets.all(0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: pokemon.color.withAlpha(150),
      ),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Text(
          text,
          style: TextStyle(
            fontFamily: 'Google',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
