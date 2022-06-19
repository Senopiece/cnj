import 'package:cnj/controllers/categories_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scale_button/scale_button.dart';

class CategoriesList extends GetView<CategoriesListController> {
  const CategoriesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(CategoriesListController());
    return Container(
      height: 400,
      width: 300,
      alignment: Alignment.center,
      child: GetBuilder<CategoriesListController>(
        builder: (context) {
          return FutureBuilder(
            future: controller.futureCategories,
            builder: (context, AsyncSnapshot<List<String>> snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return const CircularProgressIndicator();
              }

              if (snapshot.hasError) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'oops!\n While fetching the categories list some problem has occurred',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline5?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    ScaleButton(
                      onTap: controller.refreshFutureCategories,
                      child: Icon(
                        Icons.refresh,
                        size: 60,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                );
              }

              return ListView.separated(
                shrinkWrap: true,
                itemCount: snapshot.data!.length,
                separatorBuilder: (context, i) => const Divider(),
                itemBuilder: (context, i) {
                  String category = snapshot.data![i];
                  return CheckboxListTile(
                    title: Text(category),
                    value: controller.selectedCategories.contains(category),
                    onChanged: (_) => controller.toggle(category),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
