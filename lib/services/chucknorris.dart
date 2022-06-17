import 'package:cnj/models/chuck_norris_joke.dart';
import 'package:get/get.dart';

class ChuckNorrisAPI extends GetConnect implements GetxService {
  static const _apiUrl = 'https://api.chucknorris.io/jokes/random';

  Future<ChuckNorrisJoke> fetchRandomJoke() async {
    ChuckNorrisJoke joke;
    do {
      final response = await get<ChuckNorrisJoke>(
        _apiUrl,
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
