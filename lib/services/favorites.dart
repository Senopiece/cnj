import 'package:cnj/models/chuck_norris_joke.dart';
import 'package:get/get.dart';

class Favorites extends GetxService {
  void isLiked(String id) {}

  void like(ChuckNorrisJoke joke) {}

  void dislike(String id) {}

  ChuckNorrisJoke getLikedByIndex(int index) {
    throw UnimplementedError();
  }

  int getLikedLength() {
    throw UnimplementedError();
  }
}
