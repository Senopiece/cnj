import 'package:cnj/services/random_jokes_source.dart';
import 'package:get/get.dart';

class CategoriesListController extends GetxController {
  final jokesSource = Get.find<RandomJokesSource>();

  void close() {
    Get.back(); // coz it should be opened with Get.dialog
  }
}
