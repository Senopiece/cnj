import 'dart:async';

import 'package:cnj/services/chucknorris.dart';
import 'package:cnj/services/random_jokes_source.dart';
import 'package:get/get.dart';

class CategoriesListController extends GetxController {
  final _jokesSource = Get.find<RandomJokesSource>();
  final _chuck = Get.find<ChuckNorrisAPI>();

  late final Set<String> selectedCategories = Set.from(_jokesSource.categories);
  late Future<List<String>> futureCategories;

  bool categoriesLoaded = false;

  void approve() {
    if (categoriesLoaded) {
      _jokesSource.categories = selectedCategories;
      Get.back();
    }
  }

  void cancel() {
    Get.back();
  }

  @override
  void onInit() {
    super.onInit();
    refreshFutureCategories();
  }

  void refreshFutureCategories() {
    assert(!categoriesLoaded);
    futureCategories = _chuck.categoriesList;
    futureCategories.then((value) {
      categoriesLoaded = true;
      update();
    });
    update();
  }

  /// if it was switched on => switch it off (and vice versa)
  void toggle(String category) {
    if (!selectedCategories.remove(category)) {
      selectedCategories.add(category);
    }
    update();
  }
}
