import 'package:cnj/views/main_page/categories_list.dart';
import 'package:get/get.dart';

class MainPageController extends GetxController {
  void openCategories() {
    Get.defaultDialog(
      title: "",
      content: const CategoriesList(),
    );
  }

  void gotoFavorites() {}
}
