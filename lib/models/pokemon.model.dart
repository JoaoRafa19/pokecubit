import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class PokeAPI {
  List<Pokemon>? pokemons = [];

  PokeAPI({this.pokemons});

  PokeAPI.fromJson(Map<String, dynamic> json) {
    if (json['pokemon'] != null) {
      try {
        pokemons = <Pokemon>[];
        json['pokemon'].forEach((pokemon) {
          pokemons?.add(new Pokemon.fromJson(pokemon));
        });
      } catch (e) {
      }
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.pokemons != null) {
      data['pokemon'] = this.pokemons?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Pokemon {
  int? id;
  String? num;
  String? name;
  String? img;
  List<String>? type;
  String? height;
  String? weight;
  String? candy;
  int? candyCount;
  late Color bgcolor;
  String? egg;
  String? spawnTime;
  List<String>? weaknesses;
  List<NextEvolution>? nextEvolution;
  List<PrevEvolution>? prevEvolution;

  Pokemon({this.id, this.num, this.name, this.img, this.type, this.height, this.weight, this.candy, this.candyCount, this.egg, this.spawnTime, this.weaknesses, this.nextEvolution, this.prevEvolution});

  Pokemon.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    num = json['num'];
    name = json['name'];
    img = json['img'].replaceFirst("http", "https");
    type = json['type'].cast<String>();
    height = json['height'];
    weight = json['weight'];
    candy = json['candy'];
    candyCount = json['candy_count'];
    egg = json['egg'];
    spawnTime = json['spawn_time'];
    weaknesses = json['weaknesses'].cast<String>();
    if (json['next_evolution'] != null) {
      nextEvolution = <NextEvolution>[];
      json['next_evolution'].forEach((evolution) {
        nextEvolution?.add(new NextEvolution.fromJson(evolution));
      });
    }
    if (json['prev_evolution'] != null) {
      prevEvolution = <PrevEvolution>[];
      json['prev_evolution'].forEach((evolution) {
        prevEvolution?.add(new PrevEvolution.fromJson(evolution));
      });
    }
  }
  get color {
    switch (this.type![0]) {
      case 'Normal':
        return Colors.brown[400];
      case 'Fire':
        return Colors.red;
      case 'Water':
        return Colors.blue;
      case 'Grass':
        return Colors.green;
      case 'Electric':
        return Colors.amber;
      case 'Ice':
        return Colors.cyanAccent[400];
      case 'Fingting':
        return Colors.orange;
      case 'Poison':
        return Colors.purple;
      case 'Ground':
        return Colors.orange[300];
      case 'Flying':
        return Colors.indigo[200];
      case 'Psychic':
        return Colors.pink;
      case 'Bug':
        return Colors.lightGreen[500];
      case 'Rock':
        return Colors.grey;
      case 'Ghost':
        return Colors.indigo[400];
      case 'Dark':
        return Colors.brown;
      case 'Dragon':
        return Colors.indigo[800];
      case 'Steel':
        return Colors.blueGrey;
      case 'Fairy':
        return Colors.pinkAccent;
      default:
        return Colors.grey;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['num'] = this.num;
    data['name'] = this.name;
    data['img'] = this.img;
    data['type'] = this.type;
    data['height'] = this.height;
    data['weight'] = this.weight;
    data['candy'] = this.candy;
    data['candy_count'] = this.candyCount;
    data['egg'] = this.egg;
    data['spawn_time'] = this.spawnTime;
    data['weaknesses'] = this.weaknesses;
    if (this.nextEvolution != null) {
      data['next_evolution'] = this.nextEvolution!.map((v) => v.toJson()).toList();
    }
    if (this.prevEvolution != null) {
      data['prev_evolution'] = this.prevEvolution!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  Widget getImage({double? width, double? heigh}) {
    return CachedNetworkImage(
      height: heigh,
      width: width,
      imageUrl: "https://raw.githubusercontent.com/fanzeyi/pokemon.json/master/images/$num.png",
      placeholder: (BuildContext context, url) => SpinKitCircle(
        color: Colors.black,
      ),
    );
  }
}

class NextEvolution {
  String? num;
  String? name;

  NextEvolution({this.num, this.name});

  NextEvolution.fromJson(Map<String, dynamic> json) {
    num = json['num'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['num'] = this.num;
    data['name'] = this.name;
    return data;
  }
}

class PrevEvolution {
  late String num;
  late String name;

  PrevEvolution({required this.num, required this.name});

  PrevEvolution.fromJson(Map<String, dynamic> json) {
    num = json['num'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['num'] = this.num;
    data['name'] = this.name;
    return data;
  }
}
