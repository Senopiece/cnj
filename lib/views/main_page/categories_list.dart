import 'package:cnj/controllers/categories_list_controller.dart';
import 'package:cnj/views/scale_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoriesList extends GetView<CategoriesListController> {
  const CategoriesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(CategoriesListController());
    //ListView.separated();
    return Stack(
      children: [
        Container(
          color: Colors.black54,
        ),
        exitButton,
      ],
    );
  }

  Widget get exitButton => ScaleButton(
        onTap: controller.close,
        child: const Icon(
          Icons.close,
          size: 50,
        ),
      );
}
