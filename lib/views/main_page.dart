import 'package:cnj/controllers/main_page_controller.dart';
import 'package:cnj/services/random_jokes_source.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scale_button/scale_button.dart';

import 'jokes.dart';

class MainPage extends GetView<MainPageController> {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        topBar,
        const Expanded(
          child: Jokes<RandomJokesSource>(),
        ),
      ],
    );
  }

  Widget get topBar => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(top: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            categoriesButton,
            favoritesButton,
          ],
        ),
      );

  Widget get categoriesButton => ScaleButton(
        onTap: controller.openCategories,
        child: Row(
          children: [
            Text(
              'categories',
              textAlign: TextAlign.left,
              style: Get.theme.textTheme.headline5?.copyWith(fontSize: 25),
            ),
            const Icon(
              Icons.keyboard_arrow_down_rounded,
              size: 33,
            ),
          ],
        ),
      );

  Widget get favoritesButton => ScaleButton(
        onTap: controller.gotoFavorites,
        child: Row(
          children: [
            Text(
              'favorites',
              textAlign: TextAlign.right,
              style: Get.theme.textTheme.headline5?.copyWith(fontSize: 25),
            ),
            const Icon(
              Icons.keyboard_arrow_right_rounded,
              size: 33,
            ),
          ],
        ),
      );
}
