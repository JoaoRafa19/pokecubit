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

  showFilterMenu(BuildContext context, HomeCubit cubit) {
    List<Pokemon> lista = cubit.pokeapiShowList.pokemons!;

    int mySortComparison(Pokemon a, Pokemon b) {
      final double propertyA = double.parse(a.height!.split(' ')[0].replaceAll(',', '.'));
      final double propertyB = double.parse(b.height!.split(' ')[0].replaceAll(',', '.'));
      if (propertyA < propertyB) {
        return -1;
      } else if (propertyA > propertyB) {
        return 1;
      } else {
        return 0;
      }
    }

    lista.sort(mySortComparison);

    cubit.minHeight = double.parse(lista[0].height!.split(" ")[0].replaceAll(",", "."));
    cubit.maxHeight = double.parse(lista.last.height!.split(" ")[0].replaceAll(",", "."));
    if(!cubit.rangeGet){
      cubit.rangeHeight = RangeValues(cubit.minHeight!, cubit.maxHeight!);
      cubit.rangeGet = true;
    }
    cubit.rangeHeightLabels = RangeLabels(cubit.minHeight.toString(), cubit.maxHeight.toString());

    //Ordena por peso
    int mySortWeightComparison(Pokemon a, Pokemon b) {
      final double propertyA = double.parse(a.weight!.split(' ')[0].replaceAll(',','.'));
      final double propertyB = double.parse(b.weight!.split(' ')[0].replaceAll(',', '.'));
      if (propertyA < propertyB) {
        return -1;
      } else if (propertyA > propertyB) {
        return 1;
      } else {
        return 0;
      }
    }

    lista.sort(mySortWeightComparison);

    cubit.minWeight = double.parse(lista[0].weight!.split(" ")[0].replaceAll(",", "."));
    cubit.maxWeight = double.parse(lista.last.weight!.split(" ")[0].replaceAll(",", "."));
    if(!cubit.rangeWeightGet){
      cubit.rangeWeight = RangeValues(cubit.minWeight!, cubit.maxWeight!);
      cubit.rangeWeightGet = true;
    }
    cubit.rangeWeightLabels = RangeLabels(cubit.minWeight.toString(), cubit.maxWeight.toString());


    showDialog(
        context: context,
        builder: (context) {
          return FilterDialogWidget(cubit: cubit);
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
                          ),
                        )
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
                                                _cubit.pokeapiShowList.pokemons = [];
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

class FilterDialogWidget extends StatefulWidget {
  final HomeCubit cubit;
  const FilterDialogWidget({Key? key, required this.cubit}) : super(key: key);

  @override
  _FilterDialogWidgetState createState() => _FilterDialogWidgetState();
}

class _FilterDialogWidgetState extends State<FilterDialogWidget> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        content: Container(
          height: MediaQuery.of(context).size.height * 0.6,
          child: SingleChildScrollView(
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Filtro por tipos:"),
                ],
              ),
              Wrap(
                children: this.widget.cubit.types.map(
                      (tipo) => GestureDetector(
                    onTap: () => this.widget.cubit.addTypeFilter(tipo, context),
                    child: Chip(label: Text(tipo), backgroundColor: this.widget.cubit.typesFilter.contains(tipo) ? Colors.blueAccent : Colors.grey),
                  ),
                ).toList(),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text("Tamanho: "),
                    Padding(
                        padding: EdgeInsets.only(top: 5),
                        child: RangeSlider(
                          inactiveColor: Colors.black,
                          activeColor: Colors.blueAccent,
                          divisions: this.widget.cubit.maxHeight!.toInt(),
                          labels: this.widget.cubit.rangeHeightLabels,
                          values: this.widget.cubit.rangeHeight,
                          min: this.widget.cubit.minHeight!,
                          max: this.widget.cubit.maxHeight!,
                          onChanged: (range){
                            setState((){
                              this.widget.cubit.rangeHeightLabels = RangeLabels(range.start.toStringAsFixed(2), range.end.toStringAsFixed(2));
                              this.widget.cubit.rangeHeight = range;
                              this.widget.cubit.fetchPokemonList();
                            });
                          },
                        )
                    )
                  ],
                ),

              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text("Peso: "),
                    Padding(
                        padding: EdgeInsets.only(top: 5),
                        child: RangeSlider(
                          inactiveColor: Colors.black,
                          activeColor: Colors.blueAccent,
                          divisions: this.widget.cubit.maxWeight!.toInt(),
                          labels: this.widget.cubit.rangeWeightLabels,
                          values: this.widget.cubit.rangeWeight,
                          min: this.widget.cubit.minWeight!,
                          max: this.widget.cubit.maxWeight!,
                          onChanged: (range){
                            setState((){
                              this.widget.cubit.rangeWeightLabels = RangeLabels(range.start.toStringAsFixed(2), range.end.toStringAsFixed(2));
                              this.widget.cubit.rangeWeight = range;
                              this.widget.cubit.fetchPokemonList();
                            });
                          },
                        )
                    )
                  ],
                ),

              ),

              IconButton(
                icon: Icon(Icons.clear, size: 50),
                onPressed: (){
                  this.widget.cubit.typesFilter.clear();
                  this.widget.cubit.pokeapiShowList.pokemons = [];
                  this.widget.cubit.pokemonNameController.clear();
                  this.widget.cubit.fetchPokemonList();
                  this.widget.cubit.rangeWeightGet = false;
                  this.widget.cubit.rangeGet = false;
                  Navigator.of(context).pop();
                },
              ),
      ]),
          ),
    ));
  }
}
