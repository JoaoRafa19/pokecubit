import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:poke_cubit/models/pokemon.model.dart';

class PokemonDetailsPage extends StatefulWidget {
  final Pokemon pokemon;
  PokemonDetailsPage({Key? key, required this.pokemon}) : super(key: key);

  @override
  _PokemonDetailsPageState createState() => _PokemonDetailsPageState();
}

class _PokemonDetailsPageState extends State<PokemonDetailsPage> with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 10),
    vsync: this,
  )..repeat(reverse: false);
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.linear,
  );

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: (widget.pokemon.color as Color),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          // IconButton(
          //   onPressed: () {},
          //   icon: Icon(Icons.favorite),
          // ),
        ],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Hero(
              tag: "pokeball",
              child: Transform.rotate(
                angle: 60,
                child: RotationTransition(
                  turns: _animation,
                  child: Image.asset(
                    'assets/pokeball_white.png',
                    color: Colors.white.withAlpha(100),
                    width: mediaQuery.size.width * 0.9,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Align(
              alignment: Alignment.topCenter,
              child: Hero(
                tag: '${widget.pokemon.id}',
                child: widget.pokemon.getImage(width: mediaQuery.size.width * 0.7),
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
                                    "${widget.pokemon.name}",
                                    style: GoogleFonts.nunito(fontSize: 40, fontWeight: FontWeight.w800, color: Colors.grey[700]),
                                  ),
                                )
                              ],
                            ),
                            titleAndDetailWidget("Tipos", widgetRow(widget.pokemon.type)),
                            titleAndDetailWidget("Altura:", detailWidget("${widget.pokemon.height}")),
                            titleAndDetailWidget("Peso:", detailWidget("${widget.pokemon.weight}")),
                            titleAndDetailWidget("Doce:", detailWidget("${widget.pokemon.candy}")),
                            titleAndDetailWidget("spawn time:", detailWidget("${widget.pokemon.spawnTime}")),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Fraquezas: ", maxLines: 1, style: GoogleFonts.lato(fontSize: 20, fontWeight: FontWeight.bold)),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Wrap(direction: Axis.horizontal, spacing: 8.0, children: widgetRowList(widget.pokemon.weaknesses)),
                            ),
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

  Widget widgetRow(list) {
    List<Widget> lista = [];
    list!.forEach((item) {
      lista.add(Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 2.5, right: 2.5),
            margin: EdgeInsets.only(left: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: widget.pokemon.color.withAlpha(150),
            ),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                item.trim(),
                maxLines: 1,
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

  List<Widget> widgetRowList(list) {
    List<Widget> lista = [];
    list!.forEach((item) {
      lista.add(
        Container(
          padding: EdgeInsets.only(left: 2.5, right: 2.5),
          margin: EdgeInsets.only(left: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: widget.pokemon.color.withAlpha(150),
          ),
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Text(
              item.trim(),
              style: TextStyle(
                fontFamily: 'Google',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      );
    });
    return lista;
  }

  Widget detailWidget(String text) {
    return Container(
      padding: EdgeInsets.all(0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: widget.pokemon.color.withAlpha(150),
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
