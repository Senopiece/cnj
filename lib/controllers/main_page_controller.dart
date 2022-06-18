import 'package:cnj/services/random_jokes_source.dart';
import 'package:get/get.dart';

class MainPageController extends GetxController {
  final jokesSource = Get.find<RandomJokesSource>();
}
