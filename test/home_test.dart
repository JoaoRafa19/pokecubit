import 'package:flutter_test/flutter_test.dart';
import 'package:poke_cubit/modules/home/cubit/home_cubit.dart';

void main() async {
  HomeCubit homeCubit = HomeCubit();
  test("Quando abrir a tela deve carregar a lista de pokemons", () async {
    await homeCubit.fetchPokemonListTest();
    if (homeCubit.pokeapiShowList.pokemons != null) {
      expect(homeCubit.pokeapiShowList.pokemons!.isEmpty, false);
    }
  });

  test("A lista carregada deve estar em ordem alfabetica", () {
    expect(homeCubit.pokeapiShowList.pokemons![0].name, "Abra");
    expect(homeCubit.pokeapiShowList.pokemons!.last.name, "Zubat");
  });
}
