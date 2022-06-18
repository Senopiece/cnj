import 'package:cnj/controllers/main_page_controller.dart';
import 'package:cnj/services/random_jokes_source.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'jokes.dart';

class MainPage extends GetView<MainPageController> {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Jokes<RandomJokesSource>();
  }
}
