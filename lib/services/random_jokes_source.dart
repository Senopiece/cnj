import 'dart:async';

import 'package:cnj/datatypes/jokes_source.dart';
import 'package:cnj/models/chuck_norris_joke.dart';
import 'package:cnj/services/chucknorris.dart';
import 'package:get/get.dart';

class RandomJokesSource extends GetxService implements JokesSource {
  final _api = Get.find<ChuckNorrisAPI>();

  final _updateStreamCtrl = StreamController<void>.broadcast();
  var _categories = <String>[];

  List<String> get categories => _categories;

  set categories(List<String> newCategories) {
    _categories = newCategories;
    _updateStreamCtrl.add(null);
  }

  @override
  Stream<void> get updateStream => _updateStreamCtrl.stream;

  @override
  Future<ChuckNorrisJoke> getNextJoke() {
    return _api.fetchRandomJoke(categories: _categories);
  }

  @override
  void onClose() {
    _updateStreamCtrl.close();
    super.onClose();
  }
}
