import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:poke_cubit/models/pokemon.model.dart';
import 'package:poke_cubit/widgets/common/enddrawer.widget.dart';
import 'package:poke_cubit/widgets/home/pokemon.card.dart';
import 'cubit/home_cubit.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey();
  double listpadding = 100;
  bool isSearch = false;
  String filterText = '';
  List<Pokemon> lista = [];
  @override
  Widget build(BuildContext buildContext) {
    var mediaQuery = MediaQuery.of(buildContext);
    return Scaffold(
      key: _scaffoldkey,
      endDrawer: EndDrawer(),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: mediaQuery.size.height * 0.1),
          child: Center(
            child: Stack(
              //fit: StackFit.passthrough,
              alignment: Alignment.topCenter,
              clipBehavior: Clip.none,
              children: <Widget>[
                Positioned(
                  right: -150,
                  top: -190,
                  child: Stack(children: [
                    Hero(
                      tag: "pokeball",
                      child: Image.asset(
                        'assets/pokeball_white.png',
                        color: Colors.grey[300],
                        width: mediaQuery.size.width * 0.9,
                      ),
                    ),
                    Positioned(
                        top: 165,
                        right: 160,
                        child: GestureDetector(
                          child: Icon(Icons.menu, size: 50),
                          onTap: () {
                            if (_scaffoldkey.currentState != null) {
                              _scaffoldkey.currentState!.openEndDrawer();
                            }
                          },
                        ))
                  ]),
                ),
                Container(
                  padding: EdgeInsets.only(top: 20, left: mediaQuery.size.width * 0.08),
                  child: Column(
                    children: [
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: mediaQuery.size.width / 100),
                              child: Text(
                                "Pokedex",
                                style: GoogleFonts.nunito(fontSize: 50, fontWeight: FontWeight.w800, color: Colors.grey[700]),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(right: 25),
                              child: IconButton(
                                  icon: Icon(isSearch ? Icons.cancel : Icons.search, size: 50),
                                  onPressed: () {
                                    setState(() {
                                      listpadding = isSearch ? 100.0 : 200.0;
                                      isSearch = !isSearch;
                                      filterText = isSearch ? filterText : '';
                                    });
                                  }),
                            )
                          ],
                        ),
                      ),
                      isSearch
                          ? TextField(
                              maxLines: 1,
                              decoration: InputDecoration(icon: Icon(Icons.search), focusColor: Colors.black, border: InputBorder.none, hintText: "Nome do pokemon..."),
                              onChanged: (name) {
                                setState(() {
                                  filterText = name;
                                });
                              },
                            )
                          : Container(),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: listpadding),
                  child: Center(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white30,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(50), topRight: Radius.circular(20)),
                      ),
                      width: mediaQuery.size.width * 0.9,
                      height: mediaQuery.size.height * 0.8,
                      child: BlocConsumer<HomeCubit, HomeState>(listener: (context, state) {
                        if (state is HomeLoaded) {
                          lista = state.pokeapi.pokemons!;
                        }
                      }, builder: (context, state) {
                        if (state is HomeLoaded) {
                          List<Pokemon> showlist = [];
                          if (filterText.isNotEmpty) {
                            for (Pokemon poke in state.pokeapi.pokemons!) {
                              if (poke.name!.toLowerCase().contains(filterText.toLowerCase())) {
                                showlist.add(poke);
                              }
                            }
                          } else {
                            showlist.addAll(state.pokeapi.pokemons!);
                          }

                          return GridView.builder(
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                              itemCount: showlist.length,
                              itemBuilder: (item, index) {
                                return AnimationConfiguration.staggeredGrid(
                                  position: index,
                                  columnCount: 2,
                                  child: ScaleAnimation(
                                    child: GestureDetector(
                                      child: Padding(
                                        padding: EdgeInsets.all(8),
                                        child: PokeCard(
                                          index: index,
                                          pokemon: showlist[index],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              });
                        } else {
                          return SpinKitCubeGrid(color: Colors.black);
                        }
                      }),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
