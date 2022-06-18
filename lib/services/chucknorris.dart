import 'package:cnj/models/chuck_norris_joke.dart';
import 'package:get/get.dart';

class ChuckNorrisAPI extends GetConnect implements GetxService {
  static const _apiUrl = 'https://api.chucknorris.io';

  Future<List<String>> get categoriesList async {
    final response = await get<List<String>>(
      '$_apiUrl/jokes/categories',
    );

    if (response.hasError) {
      throw response;
    }

    return response.body!;
  }

  Future<ChuckNorrisJoke> fetchRandomJoke({
    List<String> categories = const [],
  }) async {
    ChuckNorrisJoke joke;
    do {
      final response = await get<ChuckNorrisJoke>(
        '$_apiUrl/jokes/random',
        query: {'category': categories},
        decoder: (obj) => ChuckNorrisJoke.fromJson(obj),
      );

      if (response.hasError) {
        throw response;
      }

      joke = response.body!;
    } while (joke.value.length > 240);

    return joke;
  }
}
