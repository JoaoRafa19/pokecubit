import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:poke_cubit/models/pokemon.model.dart';
import 'package:poke_cubit/widgets/enddrawer/cubit/drawercubit_cubit.dart';
import 'package:poke_cubit/widgets/enddrawer/enddrawer.widget.dart';
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

  showFilterMenu(BuildContext context, HomeCubit cubit  ) {
    
    showDialog(
        context: context,
        builder: (context) {
          print("OK");
          return AlertDialog(
              content: Container(
            height: MediaQuery.of(context).size.height * 0.5,
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Filtro por tipos:"),
                ],
              ),
              Wrap(
                  children: cubit.types
                      .map(
                        (tipo) => GestureDetector(
                          onTap: () => cubit.addTypeFilter(tipo, context),
                          child: Chip(label: Text(tipo), backgroundColor: cubit.typesFilter.contains(tipo) ? Colors.blueAccent : Colors.grey),
                        ),
                      )
                      .toList())
            ]),
          ));
        });
  }

  @override
  Widget build(BuildContext buildContext) {
    var mediaQuery = MediaQuery.of(buildContext);
    return Scaffold(
      key: _scaffoldkey,
      endDrawer: BlocProvider<DrawerCubit>(
        create: (context) => DrawerCubit(),
        child: EndDrawer(),
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          HomeCubit _cubit = context.watch<HomeCubit>();
          return SafeArea(
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
                                Row(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(right: 25),
                                      child: IconButton(
                                          icon: Icon(isSearch ? Icons.cancel : Icons.search, size: 50),
                                          onPressed: () {
                                            setState(() {
                                              if (isSearch) {
                                                listpadding = 100.0;
                                                _cubit.typesFilter.clear();
                                                _cubit.pokeapi.pokemons = [];
                                                _cubit.pokemonNameController.clear();
                                              } else {
                                                listpadding = 200.0;
                                                _cubit.filterText = "";
                                              }
                                              _cubit.fetchPokemonList();
                                              isSearch = !isSearch;
                                            });
                                          }),
                                    ),
                                    BlocBuilder<HomeCubit, HomeState>(
                                      builder: (context, state) {
                                        return Container(
                                          margin: EdgeInsets.only(right: 25),
                                          child: IconButton(
                                            icon: Icon(Icons.filter_list, size: 50),
                                            onPressed: () => showFilterMenu(buildContext, _cubit),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          isSearch
                              ? Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: TextField(
                                    maxLines: 1,
                                    decoration: InputDecoration(icon: Icon(Icons.search), focusColor: Colors.black, border: InputBorder.none, hintText: "Nome do pokemon..."),
                                    onChanged: (name) {
                                      print(name);
                                      _cubit.filterText = name;
                                      _cubit.fetchPokemonList();
                                      },
                                  ),
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
                          child: BlocConsumer<HomeCubit, HomeState>(
                              listener: (context, state) {},
                              builder: (context, state) {
                                if (state is HomeLoaded) {
                                  List<Pokemon> list = state.pokeapi.pokemons!;
                                  return GridView.builder(
                                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                                      itemCount: list.length,
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
                                                  pokemon: list[index],
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
          );
        },
      ),
    );
  }
}
