import 'dart:async';

import 'package:cnj/services/chucknorris.dart';
import 'package:cnj/services/random_jokes_source.dart';
import 'package:get/get.dart';

class CategoriesListController extends GetxController {
  final _jokesSource = Get.find<RandomJokesSource>();
  final _chuck = Get.find<ChuckNorrisAPI>();

  late Future<List<String>> futureCategories;
  late final StreamSubscription<void> _updates;
  Set<String> get selectedCategories => _jokesSource
      .categories; // so we do not subscribe on categories update as we assume that only this class can modify it at a time

  void refreshFutureCategories() {
    futureCategories = _chuck.categoriesList;
    update();
  }

  /// if it was switched on => switch it off (and vice versa)
  void toggle(String category) {
    if (!selectedCategories.remove(category)) {
      selectedCategories.add(category);
    }
    _jokesSource.categories = selectedCategories;
  }

  @override
  void onClose() {
    _updates.cancel();
    super.onClose();
  }

  @override
  void onInit() {
    super.onInit();
    futureCategories = _chuck.categoriesList;
    _updates = _jokesSource.updateStream.listen((event) {
      update();
    });
  }
}
