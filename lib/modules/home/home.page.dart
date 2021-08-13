import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:poke_cubit/widgets/common/enddrawer.widget.dart';
import 'package:flutter_staggered_animations/src/animation_configuration.dart';
import 'package:poke_cubit/widgets/home/pokemon.card.dart';
import 'cubit/home_cubit.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(),
      endDrawer: EndDrawer(),
      body: SafeArea(
        child: Center(
          child: Stack(
            //fit: StackFit.passthrough,
            alignment: Alignment.topCenter,
            clipBehavior: Clip.none,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 20, left: mediaQuery.size.width * 0.08),
                child: Column(
                  children: [
                    Container(
                      child: Row(
                        children: [
                          Container(
                            child: Text(
                              "Pokedex",
                              style: GoogleFonts.lato(fontSize: 30, fontWeight: FontWeight.w800),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white30,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                    ),
                    width: mediaQuery.size.width * 0.9,
                    child: BlocConsumer<HomeCubit, HomeState>(
                        listener: (context, state) {},
                        builder: (context, state) {
                          if (state is HomeLoaded) {
                            return GridView.builder(
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                                itemCount: state.pokeapi.pokemons!.length,
                                itemBuilder: (item, index) {
                                  return AnimationConfiguration.staggeredGrid(
                                    position: index,
                                    columnCount: 3,
                                    child: ScaleAnimation(child: GestureDetector(child: Padding(padding: EdgeInsets.all(8), child: PokeCard(index: index, pokemon: state.pokeapi.pokemons![index])))),
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
  }
}
