import 'package:cnj/models/chuck_norris_joke.dart';

import 'updatable.dart';

abstract class JokesSource implements Updatable {
  Future<ChuckNorrisJoke> getNextJoke() {
    throw UnimplementedError();
  }
}
