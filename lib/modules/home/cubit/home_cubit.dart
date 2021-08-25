import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:poke_cubit/models/pokemon.model.dart';
import 'package:http/http.dart';
import 'package:poke_cubit/utils/constants.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  PokeAPI pokeapi = PokeAPI(pokemons: []);

  List<String> filtroTipos = [];
  List<String> tipos = ['Normal', 'Fire', 'Water', 'Grass', 'Electric', 'Ice', 'Fingting', 'Poison', 'Ground', 'Flying', 'Psychic', 'Bug', 'Rock', 'Ghost', 'Dark', 'Dragon', 'Steel', 'Fairy'];
  String filterText = '';
  TextEditingController pokemonNameController = new TextEditingController();


  HomeCubit() : super(HomeInitial()) {
    this.fetchPokemonList();
  }

  addTypeFilter(tipo, BuildContext context) {
    if (filtroTipos.contains(tipo)) {
      filtroTipos.remove(tipo);
    } else {
      filtroTipos.add(tipo);
    }
    fetchPokemonList();
    Navigator.pop(context);
  }

  fetchPokemonList() {
    emit(HomeLoading());
    if (pokeapi.pokemons!.isEmpty) {
      pokeapi = PokeAPI(pokemons: []);
      _loadPokemons().then((pokemons) {
        pokeapi = pokemons;
        if (pokeapi.pokemons != null && pokeapi.pokemons!.isNotEmpty) {
          pokeapi.pokemons!.sort((a, b) => a.name!.toLowerCase().compareTo(b.name!.toLowerCase()));
          emit(HomeLoaded(pokeapi));
        }
      });
    } else {
      List<Pokemon> showlist = [];
      if (this.filtroTipos.isNotEmpty) {
        for (Pokemon poke in pokeapi.pokemons!) {
          for (dynamic type in filtroTipos) {
            if (poke.type!.contains(type)) {
              showlist.add(poke);
            }
          }
        }
      }
      List<Pokemon> newShowList = [];
      if (filterText.isNotEmpty) {
        for (Pokemon poke in showlist) {
          if (poke.name!.toLowerCase().contains(filterText.toLowerCase())) {
            newShowList.add(poke);
          }
        }
        showlist = newShowList;
        pokeapi.pokemons = showlist;
        emit(HomeLoaded(pokeapi));
      }
    }
  }

  Future fetchPokemonListTest() async {
    emit(HomeLoading());
    pokeapi = PokeAPI(pokemons: []);
    pokeapi = await _loadPokemons();
    if (pokeapi.pokemons != null && pokeapi.pokemons!.isNotEmpty) {
      pokeapi.pokemons!.sort((a, b) => a.name!.toLowerCase().compareTo(b.name!.toLowerCase()));
      emit(HomeLoaded(pokeapi));
    }
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
