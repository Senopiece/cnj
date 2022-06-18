import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as flutter_services;
import 'package:get/get.dart';

import 'controllers/root_controller.dart';
import 'firebase_options.dart';
import 'pages/main.dart';
import 'services/chucknorris.dart';
import 'services/network_info.dart';
import 'services/random_jokes_source.dart';
import 'themes/main.dart';
import 'views/root.dart';

Future<void> main() async {
  await runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    flutter_services.SystemChrome.setPreferredOrientations([
      flutter_services.DeviceOrientation.portraitUp,
    ]);
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
    runApp(const ChuckNorrisJokeApp());
  }, (error, stackTrace) {
    FirebaseCrashlytics.instance.recordError(error, stackTrace, fatal: true);
  });
}

class ChuckNorrisJokeApp extends StatelessWidget {
  const ChuckNorrisJokeApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Chuck Norris jokes!',
      theme: mainTheme,
      initialBinding: BindingsBuilder(
        () {
          Get.put(ChuckNorrisAPI());
          Get.put(RandomJokesSource());
          Get.put(NetworkInfo(Connectivity()));
          Get.put(RootController());
        },
      ),
      initialRoute: mainPage.name,
      getPages: [
        mainPage,
      ],
      builder: (context, content) {
        return ApplicationRoot(child: content);
      },
    );
  }
}
