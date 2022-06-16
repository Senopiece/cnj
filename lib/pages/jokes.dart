import 'package:cnj/views/jokes_page_root.dart';
import 'package:get/get.dart';

import '../controllers/jokes_page_controller.dart';

final jokesPage = GetPage(
  name: '/jokes',
  page: () => const JokesPageRoot(),
  binding: BindingsBuilder(() {
    Get.lazyPut(() => JokesPageController());
  }),
);
