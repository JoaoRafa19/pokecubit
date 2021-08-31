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
  PokeAPI pokeapiBackup = PokeAPI(pokemons: []);

  List<String> typesFilter = [];
  List<String> types = ['Normal', 'Fire', 'Water', 'Grass', 'Electric', 'Ice', 'Fighting', 'Poison', 'Ground', 'Flying', 'Psychic', 'Bug', 'Rock', 'Ghost', 'Dark', 'Dragon', 'Steel', 'Fairy'];
  String filterText = '';
  TextEditingController pokemonNameController = new TextEditingController();
  //Range tamanho
  double? minHeight;
  double? maxHeight;
  RangeValues rangeHeight = RangeValues(0, 100);
  RangeLabels? rangeHeightLabels;
  bool rangeGet = false;

  //Range Peso
  double? minWeight;
  double? maxWeight;
  RangeValues rangeWeight = RangeValues(0, 100);
  RangeLabels? rangeWeightLabels;
  bool rangeWeightGet = false;

  HomeCubit() : super(HomeInitial()) {
    this.fetchPokemonList();
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
        if (pokeapiShowList.pokemons != null &&
            pokeapiShowList.pokemons!.isNotEmpty) {
          pokeapiShowList.pokemons!.sort((a, b) =>
              a.name!.toLowerCase().compareTo(b.name!.toLowerCase()));
          pokeapiBackup = pokeapiShowList;
          emit(HomeLoaded(pokeapiShowList));
        }
      });
    } else {
      List<Pokemon> showlist = [];
      if (this.typesFilter.isNotEmpty) {
        for (Pokemon poke in pokeapiBackup.pokemons!) {
          for (dynamic type in typesFilter) {
            if (poke.type!.contains(type) && !showlist.contains(poke)) {
              showlist.add(poke);
            }
          }
        }
      } else {
        showlist.clear();
        _loadPokemons().then((pokemons) {
          pokeapiShowList = pokemons;
          if (pokeapiShowList.pokemons != null &&
              pokeapiShowList.pokemons!.isNotEmpty) {
            pokeapiShowList.pokemons!.sort((a, b) =>
                a.name!.toLowerCase().compareTo(b.name!.toLowerCase()));
          }
        });
        pokeapiShowList.pokemons!.sort((a, b) =>
            a.name!.toLowerCase().compareTo(b.name!.toLowerCase()));
        for (Pokemon poke in pokeapiBackup.pokemons!) {
          showlist.add(poke);
        }
      }

      //Filtro por nome

      if (filterText.isNotEmpty) {
        List<Pokemon> newShowList = [];
        if(showlist.isEmpty) {
          showlist = pokeapiShowList.pokemons!;
        }
        for (Pokemon poke in showlist) {
          if (poke.name!.toLowerCase().contains(filterText.toLowerCase())) {
            newShowList.add(poke);
          }
        }
        showlist = newShowList;
      }

      //Filtro por range altura
      List<Pokemon> newList = [];
      for(Pokemon poke in showlist){
        if(double.parse(poke.height!.split(' ')[0]) > rangeHeight.start && double.parse(poke.height!.split(' ')[0]) < rangeHeight.end){
            newList.add(poke);
        }
      }
      showlist = newList;


      //Filtro por range Peso
      newList = [];
      for(Pokemon poke in showlist){
        if(double.parse(poke.weight!.split(' ')[0]) > rangeWeight.start && double.parse(poke.weight!.split(' ')[0]) < rangeWeight.end){
          newList.add(poke);
        }
      }
      showlist = newList;

      PokeAPI pokelist = PokeAPI(pokemons: []);
      pokelist.pokemons = showlist;


      emit(HomeLoaded(pokelist));
    }

    Future fetchPokemonListTest() async {
      emit(HomeLoading());
      pokeapiShowList = PokeAPI(pokemons: []);
      pokeapiShowList = await _loadPokemons();
      if (pokeapiShowList.pokemons != null &&
          pokeapiShowList.pokemons!.isNotEmpty) {
        pokeapiShowList.pokemons!.sort((a, b) =>
            a.name!.toLowerCase().compareTo(b.name!.toLowerCase()));
        emit(HomeLoaded(pokeapiShowList));
      }
    }
  }
}
