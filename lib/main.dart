import 'package:cnj/pages/jokes.dart';
import 'package:cnj/themes/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as flutter_services;
import 'package:get/get.dart';

import 'services/binding.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  flutter_services.SystemChrome.setPreferredOrientations([
    flutter_services.DeviceOrientation.portraitUp,
  ]);
  runApp(const ChuckNorrisJokeApp());
}

class ChuckNorrisJokeApp extends StatelessWidget {
  const ChuckNorrisJokeApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Chuck Norris jokes!',
      theme: mainTheme,
      initialBinding: ServicesBinding(),
      initialRoute: jokesPage.name,
      getPages: [
        jokesPage,
      ],
    );
  }
}
