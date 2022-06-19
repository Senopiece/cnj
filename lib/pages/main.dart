import 'package:cnj/controllers/jokes_controller.dart';
import 'package:cnj/controllers/main_page_controller.dart';
import 'package:cnj/views/main_page.dart';
import 'package:get/get.dart';

final mainPage = GetPage(
  name: '/main',
  page: () => const MainPage(),
  binding: BindingsBuilder(() {
    Get.lazyPut(() => MainPageController());
    Get.lazyPut(() => JokesController());
  }),
);
