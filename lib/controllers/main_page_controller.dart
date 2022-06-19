import 'package:cnj/views/main_page/categories_list.dart';
import 'package:get/get.dart';

class MainPageController extends GetxController {
  void openCategories() {
    Get.dialog(
      const CategoriesList(),
    );
  }

  void gotoFavorites() {}
}
