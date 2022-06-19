import 'package:cnj/controllers/categories_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scale_button/scale_button.dart';

class CategoriesList extends GetView<CategoriesListController> {
  const CategoriesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(CategoriesListController());
    return WillPopScope(
      onWillPop: () async => false,
      child: Container(
        color: Colors.black38,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(top: 16),
                width: 300,
                child: Card(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  child: GetBuilder<CategoriesListController>(
                    builder: (context) {
                      return FutureBuilder(
                        future: controller.futureCategories,
                        builder:
                            (context, AsyncSnapshot<List<String>> snapshot) {
                          if (snapshot.connectionState !=
                              ConnectionState.done) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          if (snapshot.hasError) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  'oops!\n While fetching the categories list some problem has occurred',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline5
                                      ?.copyWith(
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
                                value: controller.selectedCategories
                                    .contains(category),
                                onChanged: (_) => controller.toggle(category),
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 14, 0, 14),
              child: GetBuilder<CategoriesListController>(
                builder: (context) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ScaleButton(
                        onTap: controller.cancel,
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Get.theme.cardColor,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.clear_rounded,
                            size: 40,
                          ),
                        ),
                      ),
                      const SizedBox(width: 50),
                      ScaleButton(
                        onTap: controller.approve,
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: controller.categoriesLoaded
                                ? Get.theme.cardColor
                                : Colors.grey,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.check_rounded,
                            size: 40,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
