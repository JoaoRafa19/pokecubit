import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:poke_cubit/models/pokemon.model.dart';
import 'package:http/http.dart';
import 'package:poke_cubit/utils/constants.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  PokeAPI pokeapi = PokeAPI(pokemons: []);

  HomeCubit() : super(HomeInitial()) {
    this.fetchPokemonList();
  }

  fetchPokemonList() {
    emit(HomeLoading());
    pokeapi = PokeAPI(pokemons: []);
    _loadPokemons().then((pokemons) {
      pokeapi = pokemons;
      if (pokeapi.pokemons != null && pokeapi.pokemons!.isNotEmpty) {
        pokeapi.pokemons!.sort((a, b) => a.name!.toLowerCase().compareTo(b.name!.toLowerCase()));
        emit(HomeLoaded(pokeapi));
        
      }
    });
  }

  Future<PokeAPI> _loadPokemons() async {
    try {
      final result = await get(Uri.parse(ConstPokeApi.baseUrl));
      Map<String, dynamic> response = jsonDecode(result.body);
      return PokeAPI.fromJson(response);
    } catch (e) {
      return PokeAPI(pokemons: []);
    }
  }
}
