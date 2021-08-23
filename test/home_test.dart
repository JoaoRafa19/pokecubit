import 'package:flutter_test/flutter_test.dart';
import 'package:poke_cubit/modules/home/cubit/home_cubit.dart';
import 'package:poke_cubit/widgets/common/sleep.func.dart';

void main() async {
  HomeCubit homeCubit = HomeCubit();
  test("Quando abrir a tela deve carregar a lista de pokemons", () async {
    await homeCubit.fetchPokemonListTest();
    if (homeCubit.pokeapi.pokemons != null) {
      expect(homeCubit.pokeapi.pokemons!.isEmpty, false);
    }
  });

  test("A lista carregada deve estar em ordem alfabetica", () {
    expect(homeCubit.pokeapi.pokemons![0].name, "Abra");
    expect(homeCubit.pokeapi.pokemons!.last.name, "Zubat");
  });
}
