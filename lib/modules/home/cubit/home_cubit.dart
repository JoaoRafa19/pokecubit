import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:poke_cubit/models/pokemon.model.dart';
import 'package:http/http.dart';
import 'package:poke_cubit/utils/constants.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  PokeAPI pokeapiShowList = PokeAPI(pokemons: []);
  PokeAPI pokeapibackup = PokeAPI(pokemons: []);

  List<String> typesFilter = [];
  List<String> types = ['Normal', 'Fire', 'Water', 'Grass', 'Electric', 'Ice', 'Fighting', 'Poison', 'Ground', 'Flying', 'Psychic', 'Bug', 'Rock', 'Ghost', 'Dark', 'Dragon', 'Steel', 'Fairy'];
  String filterText = '';
  TextEditingController pokemonNameController = new TextEditingController();
  //Range tamanho
  double? minHeight;
  double? maxHeight;
  RangeValues rangeHeight = RangeValues(0, 100);
  RangeLabels? rangeHeightLabels;


  HomeCubit() : super(HomeInitial()) {
    this.fetchPokemonList();
  }

  addTypeFilter(tipo, BuildContext context) {
    print(tipo);
    if (typesFilter.contains(tipo)) {
      typesFilter.remove(tipo);
    } else {
      typesFilter.add(tipo);
    }
    fetchPokemonList();
    Navigator.pop(context);
  }

  fetchPokemonList() {
    emit(HomeLoading());
    if (pokeapiShowList.pokemons!.isEmpty) {
      pokeapiShowList = PokeAPI(pokemons: []);
      _loadPokemons().then((pokemons) {
        pokeapiShowList = pokemons;
        if (pokeapiShowList.pokemons != null && pokeapiShowList.pokemons!.isNotEmpty) {
          pokeapiShowList.pokemons!.sort((a, b) => a.name!.toLowerCase().compareTo(b.name!.toLowerCase()));
          pokeapibackup = pokeapiShowList;
          emit(HomeLoaded(pokeapiShowList));
        }
      });
    } else {
      List<Pokemon> showlist = [];
      if (this.typesFilter.isNotEmpty) {
        for (Pokemon poke in pokeapiShowList.pokemons!) {
          for (dynamic type in typesFilter) {
            if (poke.type!.contains(type) && !showlist.contains(poke)) {
              showlist.add(poke);
            }
          }
        }
        pokeapiShowList.pokemons = showlist;
      }else{
        pokeapiShowList = pokeapibackup;
        for(Pokemon poke in pokeapiShowList.pokemons!){
          showlist.add(poke);
        }
        pokeapiShowList.pokemons = showlist;
      }

      if (filterText.isNotEmpty) {
        List<Pokemon> newShowList = [];
        showlist = showlist.isEmpty ? pokeapiShowList.pokemons! : showlist;
        for (Pokemon poke in showlist) {
          if (poke.name!.toLowerCase().contains(filterText.toLowerCase())) {
            newShowList.add(poke);
          }
        }
        showlist = newShowList;
        pokeapiShowList.pokemons = showlist;

      }
    }
    emit(HomeLoaded(pokeapiShowList));
  }

  Future fetchPokemonListTest() async {
    emit(HomeLoading());
    pokeapiShowList = PokeAPI(pokemons: []);
    pokeapiShowList = await _loadPokemons();
    if (pokeapiShowList.pokemons != null && pokeapiShowList.pokemons!.isNotEmpty) {
      pokeapiShowList.pokemons!.sort((a, b) => a.name!.toLowerCase().compareTo(b.name!.toLowerCase()));
      emit(HomeLoaded(pokeapiShowList));
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
